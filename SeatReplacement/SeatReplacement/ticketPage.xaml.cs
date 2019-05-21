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

namespace SeatReplacement
{
    /// <summary>
    /// ticketPage.xaml 的交互逻辑
    /// </summary>
    public partial class ticketPage : Page
    {
        public ticketPage()
        {
            InitializeComponent();
        }

        private void Label_MouseDown(object sender, MouseButtonEventArgs e)
        {
            NavigationService.Navigate(new Uri("pack://application:,,,/mainPage.xaml"));
        }
    }
}
