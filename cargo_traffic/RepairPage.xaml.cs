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
    /// Логика взаимодействия для RepairPage.xaml
    /// </summary>
    public partial class RepairPage : Page
    {
        private DBEntities _context;
        public RepairPage()
        {
            InitializeComponent();
            _context = DBEntities.GetContext();
            VehicleComboBox.ItemsSource = _context.транспортные_средства.ToList();
            ServiceDatePicker.SelectedDate = DateTime.Today;
        }

        private void BackBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }

        private void RegisterRepairBtn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                StringBuilder errors = new StringBuilder();
                var selectedVehicle = VehicleComboBox.SelectedItem as транспортные_средства;
                if (selectedVehicle == null)
                    errors.AppendLine("Выберите автомобиль.");
                if (ServiceDatePicker.SelectedDate == null)
                    errors.AppendLine("Укажите дату обслуживания.");
                if (string.IsNullOrWhiteSpace(DescriptionTxtBox.Text))
                    errors.AppendLine("Укажите описание работ.");
                if (!decimal.TryParse(PriceTxtBox.Text, out var price) || price < 0)
                    errors.AppendLine("Укажите корректную стоимость обслуживания.");

                if (errors.Length > 0)
                {
                    MessageBox.Show(errors.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                var service = new журнал_тех_обслуживания
                {
                    грузовой_автомобиль_id = selectedVehicle.id,
                    дата_обслуживания = ServiceDatePicker.SelectedDate.Value,
                    описание = DescriptionTxtBox.Text,
                    стоимость_обслуживания = price
                };
                _context.журнал_тех_обслуживания.Add(service);
                _context.SaveChanges();
                MessageBox.Show("Ремонт успешно зарегистрирован!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при регистрации ремонта: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
