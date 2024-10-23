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
    /// Логика взаимодействия для LoginPage.xaml
    /// </summary>
    public partial class LoginPage : Page
    {
        public LoginPage()
        {
            InitializeComponent();
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            string username = LoginTxtBox.Text;
            string password = PasswordBox.Password;

            using (var context = new DBEntities())
            {
                var user = context.пользователи.FirstOrDefault(u => u.логин == username && u.пароль == password);

                if (user != null)
                {
                    Role.role = user.роль;
                    Manager.MainFrame.Navigate(new MainPage());
                }
                else
                {
                    MessageBox.Show("Неверный логин или пароль.");
                }
            }
        }
    }
}
