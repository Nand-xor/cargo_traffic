using System;
using System.Collections.Generic;
using System.Linq;
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
    /// <summary>
    /// Логика взаимодействия для TrucksPurchasePage.xaml
    /// </summary>
    public partial class TrucksPurchasePage : Page
    {
        private DBEntities _context;
        public TrucksPurchasePage()
        {
            InitializeComponent();
            _context = DBEntities.GetContext();
        }

        private void BackBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }

        private void RegisterPurchaseBtn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                StringBuilder errors = new StringBuilder();
                if (string.IsNullOrWhiteSpace(MarkTxtBox.Text))
                    errors.AppendLine("Укажите название марки автомобиля.");
                if (string.IsNullOrWhiteSpace(ModelTxtBox.Text))
                    errors.AppendLine("Укажите модель автомобиля.");
                if (string.IsNullOrWhiteSpace(RegNumberTxtBox.Text))
                    errors.AppendLine("Укажите регистрационный номер автомобиля.");
                if (!decimal.TryParse(PriceTxtBox.Text, out var price))
                    errors.AppendLine("Укажите стоимость автомобиля.");
                if (!decimal.TryParse(CarryCapasTxtBox.Text, out var carry))
                    errors.AppendLine("Укажите грузоподъёмность автомобиля.");

                if (errors.Length > 0)
                {
                    MessageBox.Show(errors.ToString());
                    return;
                }
                var vehicle = new транспортные_средства
                {
                    марка = MarkTxtBox.Text,
                    модель = ModelTxtBox.Text,
                    регистрационный_номер = RegNumberTxtBox.Text,
                    грузоподъёмность_в_тоннах = decimal.Parse(CarryCapasTxtBox.Text),
                };
                _context.транспортные_средства.Add(vehicle);
                _context.SaveChanges();
                var last_vehicle = _context.транспортные_средства.OrderByDescending(z => z.id).FirstOrDefault();
                var buy_vehicle = new закупка_ТС
                {
                    грузовой_автомобиль_id = last_vehicle.id,
                    дата_приобретения = DateTime.Today,
                    стоимость = decimal.Parse(PriceTxtBox.Text)
                };
                _context.закупка_ТС.Add(buy_vehicle);
                var vehicle_usage = new использование_ТС_сейчас
                {
                    грузовой_автомобиль_id = last_vehicle.id,
                    в_перевозке = false
                };
                _context.использование_ТС_сейчас.Add(vehicle_usage);
                _context.SaveChanges();
                MessageBox.Show("Покупка успешно зарегистрирована!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex) {
                MessageBox.Show($"Ошибка при регистрации закупки автомобиля: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
