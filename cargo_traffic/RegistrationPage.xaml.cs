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
    /// Логика взаимодействия для RegistrationPage.xaml
    /// </summary>
    public partial class RegistrationPage : Page
    {
        public RegistrationPage()
        {
            InitializeComponent();
        }

        private void RegisterButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                StringBuilder errors = new StringBuilder();
                string username = LoginTxtBox.Text.Trim();
                string password = PasswordBox.Password;
                string confirmPassword = ConfirmPasswordBox.Password;

                if (string.IsNullOrWhiteSpace(username))
                    errors.AppendLine("Укажите логин.");
                if (string.IsNullOrWhiteSpace(password))
                    errors.AppendLine("Укажите пароль.");
                else if (password.Length < 4)
                    errors.AppendLine("Пароль должен содержать не менее 4 символов.");
                if (password != confirmPassword)
                    errors.AppendLine("Пароли не совпадают.");

                if (errors.Length > 0)
                {
                    MessageBox.Show(errors.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                using (var context = new DBEntities())
                {
                    if (context.пользователи.Any(u => u.логин == username))
                    {
                        MessageBox.Show("Пользователь с таким логином уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }

                    var user = new пользователи
                    {
                        логин = username,
                        пароль = password,
                        роль = "сотрудник"
                    };
                    context.пользователи.Add(user);
                    context.SaveChanges();
                }

                MessageBox.Show("Регистрация прошла успешно! Теперь вы можете войти.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                Manager.MainFrame.GoBack();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при регистрации: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.GoBack();
        }
    }
}
