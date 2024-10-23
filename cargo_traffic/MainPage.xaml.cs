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
    /// Логика взаимодействия для MainPage.xaml
    /// </summary>
    public partial class MainPage : Page
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private void DictionariesButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new DBRedactPage());
        }

        private void BuyCarButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new TrucksPurchasePage());
        }

        private void CloseOrderButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new ClosingOrderPage());
        }

        private void TransportButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new TransportationPage());
        }

        private void OrderButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new MakeOrderPage());
        }
    }
}
