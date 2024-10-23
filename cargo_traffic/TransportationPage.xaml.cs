using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace cargo_traffic
{
    public partial class TransportationPage : Page
    {
        private DBEntities _context;

        public TransportationPage()
        {
            InitializeComponent();
            _context = DBEntities.GetContext();
            OrderComboBox.ItemsSource = _context.заказы.ToList();
            var freeVehicles = _context.транспортные_средства.Where(v => !_context.использование_ТС_сейчас.Any(u => u.грузовой_автомобиль_id == v.id && u.в_перевозке)).ToList();

            VehicleComboBox.ItemsSource = freeVehicles;

            DriverComboBox.ItemsSource = _context.водители.ToList();
            RouteComboBox.ItemsSource = _context.маршруты.ToList();
        }
        private void RouteComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (RouteComboBox.SelectedItem is маршруты selectedRoute)
            {
                DateTime currentDateTime = DateTime.Now;
                DateTime deliveryDateTime = currentDateTime.AddMinutes(selectedRoute.ожидаемое_время_пути);
                DeliveryTimeTxtBlock.Text = deliveryDateTime.ToString();
            }
        }

        private void RegisterTransportationButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var selectedOrder = OrderComboBox.SelectedItem as заказы;
                var selectedVehicle = VehicleComboBox.SelectedItem as транспортные_средства;
                var selectedDriver = DriverComboBox.SelectedItem as водители;
                var selectedRoute = RouteComboBox.SelectedItem as маршруты;

                if (selectedOrder == null || selectedVehicle == null || selectedDriver == null || selectedRoute == null)
                {
                    MessageBox.Show("Выберите все параметры", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                var newTransportation = new перевозки
                {
                    заказ_id = selectedOrder.id,
                    грузовой_автомобиль_id = selectedVehicle.id,
                    водитель_id = selectedDriver.id,
                    маршрут_id = selectedRoute.id,
                    время_начала = DateTime.Now,
                    предполагаемое_время_доставки = DateTime.Now.AddMinutes(selectedRoute.ожидаемое_время_пути)
                };

                _context.перевозки.Add(newTransportation);

                var vehicleInUse = _context.использование_ТС_сейчас.FirstOrDefault(v => v.грузовой_автомобиль_id == selectedVehicle.id);
                if (vehicleInUse == null)
                {
                    vehicleInUse = new использование_ТС_сейчас
                    {
                        грузовой_автомобиль_id = selectedVehicle.id,
                        в_перевозке = true
                    };
                    _context.использование_ТС_сейчас.Add(vehicleInUse);
                }
                else
                {
                    vehicleInUse.в_перевозке = true;
                }

                var status = _context.статусы_заказов.FirstOrDefault(v => v.заказ_id == selectedOrder.id);
                if (status == null)
                {
                    status = new статусы_заказов
                    {
                        заказ_id = selectedOrder.id,
                        статус = "в процессе",
                        фактическая_дата_начала = DateTime.Now
                    };
                    _context.статусы_заказов.Add(status);
                }
                else
                {
                    status.статус = "в процессе";
                    status.фактическая_дата_начала = DateTime.Now;
                }
                _context.SaveChanges();
                

                MessageBox.Show("Перевозка успешно зарегистрирована!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при регистрации перевозки: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            if (this.NavigationService.CanGoBack)
            {
                this.NavigationService.GoBack();
            }
        }
    }
}
