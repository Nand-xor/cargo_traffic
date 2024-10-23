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
    /// Логика взаимодействия для DBRedactPage.xaml
    /// </summary>
    public partial class DBRedactPage : Page
    {
        private enum Dicts
        {
            drivers, profit, techService, orders, ordersCargos, trucksPurchase,
            trucksOccupancy, clients, routes, truckRemnants, shipments, users, 
            ordersStatus, tariffs, loadPoints, unloadPoints, vehicles

        }
        private static Dicts dicts;
        public DBRedactPage()
        {
            InitializeComponent();
            dicts = Dicts.orders;
            var context = DBEntities.GetContext();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата заказа", Binding = new Binding("дата_заказа") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Клиент ID", Binding = new Binding("клиент_заказчик_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Тариф ID", Binding = new Binding("тариф_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Сумма заказа", Binding = new Binding("сумма_заказа") });
            MainDataGrid.ItemsSource = context.заказы.ToList();
            if (Role.role != "администратор")
            {
                MainDataGrid.IsReadOnly = true;
                SaveBtn.Visibility = Visibility.Hidden;
                AddBtn.Visibility = Visibility.Hidden;
                DeleteBtn.Visibility = Visibility.Hidden;
            }
        }

        private void DriversBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "ФИО", Binding = new Binding("ФИО") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Стаж работы в годах", Binding = new Binding("стаж_работы_в_годах") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Водительское удостоверение", Binding = new Binding("номер_водительского_удостоверения") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Телефон", Binding = new Binding("телефон") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().водители.ToList();
            dicts = Dicts.drivers;
        }

        private void ProfitBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Заказ", Binding = new Binding("заказ_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Оплата", Binding = new Binding("оплата") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата оплаты", Binding = new Binding("дата_оплаты") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().доходы.ToList();
            dicts = Dicts.profit;
        }

        private void TechServiceBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Грузовик", Binding = new Binding("грузовой_автомобиль_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата обслуживания", Binding = new Binding("дата_обслуживания") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Описание", Binding = new Binding("описание") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Стоимость", Binding = new Binding("стоимость_обслуживания") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().журнал_тех_обслуживания.ToList();
            dicts = Dicts.techService;
        }

        private void OrdersBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата заказа", Binding = new Binding("дата_заказа") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Клиент ID", Binding = new Binding("клиент_заказчик_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Тариф ID", Binding = new Binding("тариф_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Сумма заказа", Binding = new Binding("сумма_заказа") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().заказы.ToList();
            dicts = Dicts.orders;
        }

        private void OrdersCargosBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Груз", Binding = new Binding("название") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Вес в кг", Binding = new Binding("вес_в_кг") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Кол-во", Binding = new Binding("количество") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Заказ", Binding = new Binding("заказ_id") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().заказы_грузы.ToList();
            dicts = Dicts.ordersCargos;
        }

        private void TrucksPurchaseBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Номер грузовика", Binding = new Binding("грузовой_автомобиль_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата покупки", Binding = new Binding("дата_приобретения") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Цена в рублях", Binding = new Binding("стоимость") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().закупка_ТС.ToList();
            dicts = Dicts.trucksPurchase;
        }

        private void TrucksOccupancyBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("грузовой_автомобиль_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Занят", Binding = new Binding("в_перевозке") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().использование_ТС_сейчас.ToList();
            dicts = Dicts.trucksOccupancy;
        }

        private void ClientsBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Название компании", Binding = new Binding("название_компании") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Адрес", Binding = new Binding("адрес") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Контактное лицо", Binding = new Binding("контактное_лицо") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Телефон", Binding = new Binding("телефон") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Email", Binding = new Binding("email") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().клиенты.ToList();
            dicts = Dicts.clients;
        }

        private void RoutesBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Номер точки погрузки", Binding = new Binding("точка_погрузки_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Номер точки разгрузки", Binding = new Binding("точка_разгрузки_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Описание маршрута", Binding = new Binding("описание") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Путь в км", Binding = new Binding("длина_в_км") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Ожидаемое время пути в минутах", Binding = new Binding("ожидаемое_время_пути") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().маршруты.ToList();
            dicts = Dicts.routes;
        }

        private void TruckRemnantsBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Марка", Binding = new Binding("марка") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Модель", Binding = new Binding("модель") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Число свободных грузовиков", Binding = new Binding("количество_незадействованных") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().остатки_ТС.ToList();
            dicts = Dicts.truckRemnants;
        }

        private void ShipmentsBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Заказ", Binding = new Binding("заказ_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Номер грузовика", Binding = new Binding("грузовой_автомобиль_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Номер водителя", Binding = new Binding("водитель_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Номер маршрута", Binding = new Binding("маршрут_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Дата начала перевозки", Binding = new Binding("время_начала") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Предположительное время доставки", Binding = new Binding("предполагаемое_время_доставки") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().перевозки.ToList();
            dicts = Dicts.shipments;
        }

        private void UsersBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Логин", Binding = new Binding("логин") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Пароль", Binding = new Binding("пароль") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Роль", Binding = new Binding("роль") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().пользователи.ToList();
            dicts = Dicts.users;
        }

        private void OrdersStatusBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Заказ", Binding = new Binding("заказ_id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Статус", Binding = new Binding("статус") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "фактическая дата начала", Binding = new Binding("фактическая_дата_начала") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "фактическая дата окончания", Binding = new Binding("фактическая_дата_окончания") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().статусы_заказов.ToList();
            dicts = Dicts.ordersStatus;
        }

        private void TariffsBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Название", Binding = new Binding("название") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Плата за кг в рублях", Binding = new Binding("плата_за_кг_в_рублях") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "плата за км в рублях", Binding = new Binding("плата_за_км_в_рублях") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().тарифы.ToList();
            dicts = Dicts.tariffs;
        }

        private void LoadPointsBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Адрес", Binding = new Binding("адрес") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Название", Binding = new Binding("название") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().точки_погрузки.ToList();
            dicts = Dicts.loadPoints;
        }

        private void UnloadPointsBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Адрес", Binding = new Binding("адрес") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Название", Binding = new Binding("название") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().точки_разгрузки.ToList();
            dicts = Dicts.unloadPoints;
        }

        private void VehiclesBtn_Click(object sender, RoutedEventArgs e)
        {
            MainDataGrid.Columns.Clear();
            MainDataGrid.AutoGenerateColumns = false;
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("id") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Марка", Binding = new Binding("марка") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Модель", Binding = new Binding("модель") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Регистрационный номер", Binding = new Binding("регистрационный_номер") });
            MainDataGrid.Columns.Add(new DataGridTextColumn { Header = "Грузоподъёмность в тоннах", Binding = new Binding("грузоподъёмность_в_тоннах") });
            MainDataGrid.ItemsSource = DBEntities.GetContext().транспортные_средства.ToList();
            dicts = Dicts.vehicles;
        }

        private void SaveChanges(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Вы уверены, что хотите сохранить изменения?", "Подтверждение удаления",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question,
                MessageBoxResult.No
            );
            if (result == MessageBoxResult.Yes)
            {
                try
                {
                    DBEntities.GetContext().SaveChanges();
                    MessageBox.Show("Данные успешно сохранены");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }

        private void DeleteChanges(object sender, RoutedEventArgs e)
        {
            switch (dicts)
            {
                case Dicts.drivers:
                    var driver = MainDataGrid.SelectedItems.Cast<водители>().ToList();
                    DBEntities.GetContext().водители.RemoveRange(driver);
                    break;
                case Dicts.profit:
                    var profits = MainDataGrid.SelectedItems.Cast<доходы>().ToList();
                    DBEntities.GetContext().доходы.RemoveRange(profits);
                    break;
                case Dicts.techService:
                    var techServices = MainDataGrid.SelectedItems.Cast<журнал_тех_обслуживания>().ToList();
                    DBEntities.GetContext().журнал_тех_обслуживания.RemoveRange(techServices);
                    break;
                case Dicts.orders:
                    var order = MainDataGrid.SelectedItems.Cast<заказы>().ToList();
                    DBEntities.GetContext().заказы.RemoveRange(order);
                    break;
                case Dicts.ordersCargos:
                    var orderCargo = MainDataGrid.SelectedItems.Cast<заказы_грузы>().ToList();
                    DBEntities.GetContext().заказы_грузы.RemoveRange(orderCargo);
                    break;
                case Dicts.trucksPurchase:
                    var truckPurchase = MainDataGrid.SelectedItems.Cast<закупка_ТС>().ToList();
                    DBEntities.GetContext().закупка_ТС.RemoveRange(truckPurchase);
                    break;
                case Dicts.trucksOccupancy:
                    var truckOccupance = MainDataGrid.SelectedItems.Cast<использование_ТС_сейчас>().ToList();
                    DBEntities.GetContext().использование_ТС_сейчас.RemoveRange(truckOccupance);
                    break;
                case Dicts.clients:
                    var client = MainDataGrid.SelectedItems.Cast<клиенты>().ToList();
                    DBEntities.GetContext().клиенты.RemoveRange(client);
                    break;
                case Dicts.routes:
                    var route = MainDataGrid.SelectedItems.Cast<маршруты>().ToList();
                    DBEntities.GetContext().маршруты.RemoveRange(route);
                    break;
                case Dicts.truckRemnants:
                    var truckRemnant = MainDataGrid.SelectedItems.Cast<остатки_ТС>().ToList();
                    DBEntities.GetContext().остатки_ТС.RemoveRange(truckRemnant);
                    break;
                case Dicts.shipments:
                    var shipment = MainDataGrid.SelectedItems.Cast<перевозки>().ToList();
                    DBEntities.GetContext().перевозки.RemoveRange(shipment);
                    break;
                case Dicts.users:
                    var user = MainDataGrid.SelectedItems.Cast<пользователи>().ToList();
                    DBEntities.GetContext().пользователи.RemoveRange(user);
                    break;
                case Dicts.ordersStatus:
                    var ordersStatus = MainDataGrid.SelectedItems.Cast<статусы_заказов>().ToList();
                    DBEntities.GetContext().статусы_заказов.RemoveRange(ordersStatus);
                    break;
                case Dicts.tariffs:
                    var tariff = MainDataGrid.SelectedItems.Cast<тарифы>().ToList();
                    DBEntities.GetContext().тарифы.RemoveRange(tariff);
                    break;
                case Dicts.loadPoints:
                    var loadPoint = MainDataGrid.SelectedItems.Cast<точки_погрузки>().ToList();
                    DBEntities.GetContext().точки_погрузки.RemoveRange(loadPoint);
                    break;
                case Dicts.unloadPoints:
                    var unloadPoint = MainDataGrid.SelectedItems.Cast<точки_разгрузки>().ToList();
                    DBEntities.GetContext().точки_разгрузки.RemoveRange(unloadPoint);
                    break;
                case Dicts.vehicles:
                    var vehicle = MainDataGrid.SelectedItems.Cast<транспортные_средства>().ToList();
                    DBEntities.GetContext().транспортные_средства.RemoveRange(vehicle);
                    break;
            }
        }

        private void GoBack(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }

        private void AddBtn_Click(object sender, RoutedEventArgs e)
        {
            switch (dicts)
            {
                case Dicts.drivers:
                    var driver = MainDataGrid.SelectedItems.Cast<водители>().ToList();
                    DBEntities.GetContext().водители.AddRange(driver);
                    break;
                case Dicts.profit:
                    var profits = MainDataGrid.SelectedItems.Cast<доходы>().ToList();
                    DBEntities.GetContext().доходы.AddRange(profits);
                    break;
                case Dicts.techService:
                    var techServices = MainDataGrid.SelectedItems.Cast<журнал_тех_обслуживания>().ToList();
                    DBEntities.GetContext().журнал_тех_обслуживания.AddRange(techServices);
                    break;
                case Dicts.orders:
                    var order = MainDataGrid.SelectedItems.Cast<заказы>().ToList();
                    DBEntities.GetContext().заказы.AddRange(order);
                    break;
                case Dicts.ordersCargos:
                    var orderCargo = MainDataGrid.SelectedItems.Cast<заказы_грузы>().ToList();
                    DBEntities.GetContext().заказы_грузы.AddRange(orderCargo);
                    break;
                case Dicts.trucksPurchase:
                    var truckPurchase = MainDataGrid.SelectedItems.Cast<закупка_ТС>().ToList();
                    DBEntities.GetContext().закупка_ТС.AddRange(truckPurchase);
                    break;
                case Dicts.trucksOccupancy:
                    var truckOccupance = MainDataGrid.SelectedItems.Cast<использование_ТС_сейчас>().ToList();
                    DBEntities.GetContext().использование_ТС_сейчас.AddRange(truckOccupance);
                    break;
                case Dicts.clients:
                    var client = MainDataGrid.SelectedItems.Cast<клиенты>().ToList();
                    DBEntities.GetContext().клиенты.AddRange(client);
                    break;
                case Dicts.routes:
                    var route = MainDataGrid.SelectedItems.Cast<маршруты>().ToList();
                    DBEntities.GetContext().маршруты.AddRange(route);
                    break;
                case Dicts.truckRemnants:
                    var truckRemnant = MainDataGrid.SelectedItems.Cast<остатки_ТС>().ToList();
                    DBEntities.GetContext().остатки_ТС.AddRange(truckRemnant);
                    break;
                case Dicts.shipments:
                    var shipment = MainDataGrid.SelectedItems.Cast<перевозки>().ToList();
                    DBEntities.GetContext().перевозки.AddRange(shipment);
                    break;
                case Dicts.users:
                    var user = MainDataGrid.SelectedItems.Cast<пользователи>().ToList();
                    DBEntities.GetContext().пользователи.AddRange(user);
                    break;
                case Dicts.ordersStatus:
                    var ordersStatus = MainDataGrid.SelectedItems.Cast<статусы_заказов>().ToList();
                    DBEntities.GetContext().статусы_заказов.AddRange(ordersStatus);
                    break;
                case Dicts.tariffs:
                    var tariff = MainDataGrid.SelectedItems.Cast<тарифы>().ToList();
                    DBEntities.GetContext().тарифы.AddRange(tariff);
                    break;
                case Dicts.loadPoints:
                    var loadPoint = MainDataGrid.SelectedItems.Cast<точки_погрузки>().ToList();
                    DBEntities.GetContext().точки_погрузки.AddRange(loadPoint);
                    break;
                case Dicts.unloadPoints:
                    var unloadPoint = MainDataGrid.SelectedItems.Cast<точки_разгрузки>().ToList();
                    DBEntities.GetContext().точки_разгрузки.AddRange(unloadPoint);
                    break;
                case Dicts.vehicles:
                    var vehicle = MainDataGrid.SelectedItems.Cast<транспортные_средства>().ToList();
                    DBEntities.GetContext().транспортные_средства.AddRange(vehicle);
                    break;
            }
        }
    }
}
