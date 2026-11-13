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
    /// Логика взаимодействия для ReportsPage.xaml
    /// </summary>
    public partial class ReportsPage : Page
    {
        public enum ReportKind
        {
            Income,
            Expenses,
            Profit
        }

        private readonly ReportKind _kind;
        private readonly DBEntities _context;

        private class IncomeRow
        {
            public int Номер { get; set; }
            public int Заказ { get; set; }
            public decimal Оплата { get; set; }
            public DateTime Дата_оплаты { get; set; }
        }

        private class ExpenseRow
        {
            public DateTime Дата { get; set; }
            public string Категория { get; set; }
            public string Описание { get; set; }
            public decimal Сумма { get; set; }
        }

        private class ProfitRow
        {
            public string Месяц { get; set; }
            public decimal Доходы { get; set; }
            public decimal Расходы { get; set; }
            public decimal Прибыль { get; set; }
        }

        public ReportsPage(ReportKind kind)
        {
            InitializeComponent();
            _kind = kind;
            _context = DBEntities.GetContext();
            switch (_kind)
            {
                case ReportKind.Income:
                    ReportTitleText.Text = "Отчёт по доходам";
                    break;
                case ReportKind.Expenses:
                    ReportTitleText.Text = "Отчёт по расходам";
                    break;
                case ReportKind.Profit:
                    ReportTitleText.Text = "Отчёт по прибыли";
                    break;
            }
            BuildReport();
        }

        private void OnPeriodChanged(object sender, SelectionChangedEventArgs e)
        {
            BuildReport();
        }

        private void ResetPeriod_Click(object sender, RoutedEventArgs e)
        {
            FromDatePicker.SelectedDate = null;
            ToDatePicker.SelectedDate = null;
            BuildReport();
        }

        private bool InPeriod(DateTime date)
        {
            var from = FromDatePicker.SelectedDate;
            var to = ToDatePicker.SelectedDate;
            if (from.HasValue && date < from.Value.Date)
                return false;
            if (to.HasValue && date > to.Value.Date)
                return false;
            return true;
        }

        private List<IncomeRow> GetIncomes()
        {
            return _context.доходы.ToList()
                .Where(i => InPeriod(i.дата_оплаты))
                .OrderBy(i => i.дата_оплаты)
                .Select(i => new IncomeRow
                {
                    Номер = i.id,
                    Заказ = i.заказ_id,
                    Оплата = i.оплата,
                    Дата_оплаты = i.дата_оплаты
                })
                .ToList();
        }

        private List<ExpenseRow> GetExpenses()
        {
            var purchases = _context.закупка_ТС.ToList()
                .Select(p => new ExpenseRow
                {
                    Дата = p.дата_приобретения,
                    Категория = "Закупка ТС",
                    Описание = "Приобретение автомобиля №" + p.грузовой_автомобиль_id,
                    Сумма = p.стоимость
                });
            var services = _context.журнал_тех_обслуживания.ToList()
                .Select(s => new ExpenseRow
                {
                    Дата = s.дата_обслуживания,
                    Категория = "Тех. обслуживание",
                    Описание = s.описание,
                    Сумма = s.стоимость_обслуживания
                });
            return purchases.Concat(services)
                .Where(e => InPeriod(e.Дата))
                .OrderBy(e => e.Дата)
                .ToList();
        }

        private void BuildReport()
        {
            switch (_kind)
            {
                case ReportKind.Income:
                    var incomes = GetIncomes();
                    ReportGrid.ItemsSource = incomes;
                    TotalText.Text = $"Итого доходы: {incomes.Sum(i => i.Оплата):N2} руб.";
                    break;
                case ReportKind.Expenses:
                    var expenses = GetExpenses();
                    ReportGrid.ItemsSource = expenses;
                    TotalText.Text = $"Итого расходы: {expenses.Sum(e => e.Сумма):N2} руб.";
                    break;
                case ReportKind.Profit:
                    var incomeList = GetIncomes();
                    var expenseList = GetExpenses();
                    var months = incomeList.Select(i => new DateTime(i.Дата_оплаты.Year, i.Дата_оплаты.Month, 1))
                        .Concat(expenseList.Select(e => new DateTime(e.Дата.Year, e.Дата.Month, 1)))
                        .Distinct()
                        .OrderBy(m => m)
                        .ToList();
                    var rows = months.Select(m =>
                    {
                        var inc = incomeList
                            .Where(i => i.Дата_оплаты.Year == m.Year && i.Дата_оплаты.Month == m.Month)
                            .Sum(i => i.Оплата);
                        var exp = expenseList
                            .Where(e => e.Дата.Year == m.Year && e.Дата.Month == m.Month)
                            .Sum(e => e.Сумма);
                        return new ProfitRow
                        {
                            Месяц = m.ToString("MMMM yyyy"),
                            Доходы = inc,
                            Расходы = exp,
                            Прибыль = inc - exp
                        };
                    }).ToList();
                    ReportGrid.ItemsSource = rows;
                    var totalIncome = rows.Sum(r => r.Доходы);
                    var totalExpenses = rows.Sum(r => r.Расходы);
                    TotalText.Text = $"Итого прибыль: {totalIncome - totalExpenses:N2} руб.\nДоходы: {totalIncome:N2} руб. Расходы: {totalExpenses:N2} руб.";
                    break;
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }
    }
}
