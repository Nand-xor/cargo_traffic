using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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
    /// Логика взаимодействия для ClosingOrderPage.xaml
    /// </summary>
    public partial class ClosingOrderPage : Page
    {
        private DBEntities _context;
        public ClosingOrderPage()
        {
            InitializeComponent();
            _context = DBEntities.GetContext();
            OrderComboBox.ItemsSource = _context.заказы.ToList();
        }

        private void CloseOrderButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var selectedOrder = OrderComboBox.SelectedItem as заказы;
                if (selectedOrder == null || !decimal.TryParse(PaymentTxtBox.Text, out var pay))
                {
                    MessageBox.Show("Выберите заказ и укажите сумму для его закрытия", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                var order = _context.заказы.FirstOrDefault(v => v.id == selectedOrder.id);
                if (order.сумма_заказа != decimal.Parse(PaymentTxtBox.Text))
                { 
                    MessageBox.Show("Оплата не соответствует сумме заказа, заказ не может быть закрыт", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                var status = _context.статусы_заказов.FirstOrDefault(v => v.заказ_id == selectedOrder.id);
                status.статус = "выполнен";
                status.фактическая_дата_окончания = DateTime.Now;
                var new_profit = new доходы
                {
                    заказ_id = selectedOrder.id,
                    оплата = decimal.Parse(PaymentTxtBox.Text),
                    дата_оплаты = DateTime.Now
                };
                _context.доходы.Add(new_profit);
                var transportation = _context.перевозки.FirstOrDefault(v => v.заказ_id == selectedOrder.id);
                var vehicle_status = _context.использование_ТС_сейчас.FirstOrDefault(v => v.грузовой_автомобиль_id == transportation.грузовой_автомобиль_id);
                vehicle_status.в_перевозке = false;
                _context.SaveChanges();
                MessageBox.Show("Заказ был успешно закрыт!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при закрытии заказы: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }
    }
}
