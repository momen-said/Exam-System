using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace examination_app
{
    public partial class Login_form : Form
    {
        public Login_form()
        {
            InitializeComponent();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            

        }

        private void button9_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=.;Initial Catalog=Examination_System;Integrated Security=True");
            SqlCommand cmd1 = new SqlCommand("exec login_user '" + textBox1.Text + "','" + textBox2.Text + "'", conn);
            SqlDataAdapter sda = new SqlDataAdapter(cmd1);
            DataTable dta = new DataTable();
            sda.Fill(dta);
            if (dta.Rows[0][0].ToString() == "1")
            {
                SqlCommand cmd3 = new SqlCommand(@"INSERT INTO[dbo].[login] ([login_user],[password]) VALUES ('" + textBox1.Text + "','" + textBox2.Text + "')", conn);
                conn.Open();
                cmd3.ExecuteNonQuery();
                conn.Close();
                this.Hide();
                coursesform ss = new coursesform();
                ss.Show();
            }
            else
            {
                MessageBox.Show("invalid email or password !");
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Hide();
            registration ss = new registration();
            ss.Show();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Follow the steps carfully in the next page");
        }

        private void button7_Click(object sender, EventArgs e)
        {
            MessageBox.Show("People develop countries, We develop P.E.O.P.L.E");
        }

        private void button6_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Support Email: ITIinfo@iti.gov.eg");
        }
    }
}
