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
    public partial class coursesform : Form
    {
        string name;
        public coursesform()
        {
            InitializeComponent();
            SqlConnection conn2 = new SqlConnection("Data Source=.;Initial Catalog=Examination_System;Integrated Security=True");
            SqlCommand cmd3 = new SqlCommand("exec label_1_1", conn2);
            conn2.Open();
            label2.Text = Convert.ToString(cmd3.ExecuteScalar());
            conn2.Close();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            SqlConnection conn2 = new SqlConnection("Data Source=.;Initial Catalog=Examination_System;Integrated Security=True");
            SqlCommand cmd_course = new SqlCommand("insert_selected_course '" + name + "'", conn2);
            conn2.Open();
            cmd_course.ExecuteNonQuery();
            conn2.Close();
            this.Hide();
            exams_page ss = new exams_page();
            ss.Show();
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            name = "SQL";
        }

        private void radioButton6_CheckedChanged(object sender, EventArgs e)
        {
            name = "C#";
        }

        private void radioButton5_CheckedChanged(object sender, EventArgs e)
        {
            name = "Python";
        }

        private void coursesform_Load(object sender, EventArgs e)
        {

        }
    }
}
