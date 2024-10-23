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
using System.Data.Entity;

namespace cargo_traffic
{
    public partial class MakeOrderPage : Page
    {
        private DBEntities _context;
        public MakeOrderPage()
        {
            InitializeComponent();
            _context = DBEntities.GetContext();

            TariffComboBox.ItemsSource = _context.тарифы.ToList();
            ClientComboBox.ItemsSource = _context.клиенты.ToList();

            CargoWeightTextBox.TextChanged += OnInputChanged;
            CargoQuantityTextBox.TextChanged += OnInputChanged;
            TariffComboBox.SelectionChanged += OnInputChanged;
        }

        private void OnInputChanged(object sender, RoutedEventArgs e)
        {
            CalculateOrderAmount();
        }

        private void CalculateOrderAmount()
        {
            if (TariffComboBox.SelectedItem is тарифы selectedTariff &&
                decimal.TryParse(CargoWeightTextBox.Text, out var cargoWeight) &&
                int.TryParse(CargoQuantityTextBox.Text, out var cargoQuantity))
            {
                if (cargoWeight * cargoQuantity < 500000)
                {
                    OrderAmountTextBlock.Text = (cargoWeight * cargoQuantity * selectedTariff.плата_за_кг_в_рублях).ToString("F2");
                }
                else
                {
                    OrderAmountTextBlock.Text = "0.00";
                }
            }
            else
            {
                OrderAmountTextBlock.Text = "0.00";
            }
        }

        private void RegisterOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (ClientComboBox.SelectedItem is клиенты selectedClient &&
                TariffComboBox.SelectedItem is тарифы selectedTariff &&
                decimal.TryParse(CargoWeightTextBox.Text, out var cargoWeight) &&
                int.TryParse(CargoQuantityTextBox.Text, out var cargoQuantity))
            {
                var orderAmount = cargoWeight * cargoQuantity * selectedTariff.плата_за_кг_в_рублях;
                var заказ = new заказы
                {
                    клиент_заказчик_id = selectedClient.id,
                    тариф_id = selectedTariff.id,
                    дата_заказа = DateTime.Now,
                    сумма_заказа = orderAmount
                };

                _context.заказы.Add(заказ);
                _context.SaveChanges();
                var заказы_id = _context.заказы.OrderByDescending(z => z.id).FirstOrDefault().id;
                var заказ_груз = new заказы_грузы
                {
                    название = CargoNameTxtBox.Text,
                    вес_в_кг = cargoWeight,
                    количество = cargoQuantity,
                    заказ_id = заказы_id
                };
                _context.заказы_грузы.Add(заказ_груз);
                _context.SaveChanges();
                var статус_заказа = new статусы_заказов
                {
                    заказ_id = заказы_id,
                    статус = "в очереди"
                };
                _context.статусы_заказов.Add(статус_заказа);
                _context.SaveChanges();
                

                MessageBox.Show("Заказ успешно зарегистрирован");
            }
            else
            {
                MessageBox.Show("Пожалуйста, заполните все поля как следует.");
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }
    }
}
