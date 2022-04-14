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
    public partial class exams_page : Form
    {
        private const CommandType storedProcedure = CommandType.StoredProcedure;
        string submitted_answer1;
        string submitted_answer2;
        string submitted_answer3;
        string submitted_answer4;
        string submitted_answer5;
        string submitted_answer6;
        string submitted_answer7;
        string submitted_answer8;
        string submitted_answer9;
        string submitted_answer10;
        int exam_id;
        public exams_page()
        {
            InitializeComponent();
            string name;
            Random rnd = new Random();
            label14.Text = Convert.ToString(rnd.Next(100,100000));
            exam_id = Convert.ToInt32(label14.Text);
            SqlConnection conn = new SqlConnection("Data Source=.;Initial Catalog=Examination_System;Integrated Security=True");
            SqlCommand exam_name = new SqlCommand("exam_name_out", conn);
            SqlCommand quest_genr = new SqlCommand("exec quest_sql_out", conn);
            /*SqlDataAdapter data = new SqlDataAdapter(quest_genr);
            DataSet dt2 = new DataSet();
            data.Fill(dt2);*/
            conn.Open();
            label11.Text = Convert.ToString(exam_name.ExecuteScalar());
            List<string> lst = new List<string>();
            int count = 0;
            for (int i = 0; i <= 11; i++)
            {
                name = Convert.ToString(quest_genr.ExecuteScalar());
                count++;
                if (!lst.Contains(name))
                {
                    lst.Add(name);
                }
            }
            if (count >= 4)
            {
                label1.Text = Convert.ToString(lst[0]);
                label2.Text = Convert.ToString(lst[1]);
                label3.Text = Convert.ToString(lst[2]);
                label4.Text = Convert.ToString(lst[3]);
                label5.Text = Convert.ToString(lst[4]);
                label6.Text = Convert.ToString(lst[5]);
                label7.Text = Convert.ToString(lst[6]);
                label8.Text = Convert.ToString(lst[7]);
                label9.Text = Convert.ToString(lst[8]);
                label10.Text = Convert.ToString(lst[9]);
            }
            SqlCommand cmd_choices1 = new SqlCommand("question_choices_proc", conn);
            cmd_choices1.CommandType = storedProcedure;
            cmd_choices1.Parameters.Add("@label", SqlDbType.VarChar,200).Value = label1.Text.ToString();
            cmd_choices1.Parameters.Add("@1st_choice", SqlDbType.NVarChar,50).Direction = ParameterDirection.Output;
            cmd_choices1.Parameters.Add("@2nd_choice", SqlDbType.NVarChar,50).Direction = ParameterDirection.Output;
            cmd_choices1.Parameters.Add("@3rd_choice", SqlDbType.NVarChar,50).Direction = ParameterDirection.Output;
            cmd_choices1.Parameters.Add("@4th_choice", SqlDbType.NVarChar,50).Direction = ParameterDirection.Output;
            cmd_choices1.ExecuteScalar();
            radioButton1.Text = Convert.ToString(cmd_choices1.Parameters["@1st_choice"].Value.ToString());
            radioButton2.Text = Convert.ToString(cmd_choices1.Parameters["@2nd_choice"].Value.ToString());
            radioButton3.Text = Convert.ToString(cmd_choices1.Parameters["@3rd_choice"].Value.ToString());
            radioButton4.Text = Convert.ToString(cmd_choices1.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices2 = new SqlCommand("question_choices_proc", conn);
            cmd_choices2.CommandType = storedProcedure;
            cmd_choices2.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label2.Text.ToString();
            cmd_choices2.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices2.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices2.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices2.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices2.ExecuteScalar();
            radioButton5.Text = Convert.ToString(cmd_choices2.Parameters["@1st_choice"].Value.ToString());
            radioButton6.Text = Convert.ToString(cmd_choices2.Parameters["@2nd_choice"].Value.ToString());
            radioButton7.Text = Convert.ToString(cmd_choices2.Parameters["@3rd_choice"].Value.ToString());
            radioButton8.Text = Convert.ToString(cmd_choices2.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices3 = new SqlCommand("question_choices_proc", conn);
            cmd_choices3.CommandType = storedProcedure;
            cmd_choices3.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label3.Text.ToString();
            cmd_choices3.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices3.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices3.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices3.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices3.ExecuteScalar();
            radioButton9.Text = Convert.ToString(cmd_choices3.Parameters["@1st_choice"].Value.ToString());
            radioButton10.Text = Convert.ToString(cmd_choices3.Parameters["@2nd_choice"].Value.ToString());
            radioButton11.Text = Convert.ToString(cmd_choices3.Parameters["@3rd_choice"].Value.ToString());
            radioButton12.Text = Convert.ToString(cmd_choices3.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices4 = new SqlCommand("question_choices_proc", conn);
            cmd_choices4.CommandType = storedProcedure;
            cmd_choices4.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label4.Text.ToString();
            cmd_choices4.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices4.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices4.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices4.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices4.ExecuteScalar();
            radioButton13.Text = Convert.ToString(cmd_choices4.Parameters["@1st_choice"].Value.ToString());
            radioButton14.Text = Convert.ToString(cmd_choices4.Parameters["@2nd_choice"].Value.ToString());
            radioButton15.Text = Convert.ToString(cmd_choices4.Parameters["@3rd_choice"].Value.ToString());
            radioButton16.Text = Convert.ToString(cmd_choices4.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices5 = new SqlCommand("question_choices_proc", conn);
            cmd_choices5.CommandType = storedProcedure;
            cmd_choices5.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label5.Text.ToString();
            cmd_choices5.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices5.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices5.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices5.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices5.ExecuteScalar();
            radioButton17.Text = Convert.ToString(cmd_choices5.Parameters["@1st_choice"].Value.ToString());
            radioButton18.Text = Convert.ToString(cmd_choices5.Parameters["@2nd_choice"].Value.ToString());
            radioButton19.Text = Convert.ToString(cmd_choices5.Parameters["@3rd_choice"].Value.ToString());
            radioButton20.Text = Convert.ToString(cmd_choices5.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices6 = new SqlCommand("question_choices_proc", conn);
            cmd_choices6.CommandType = storedProcedure;
            cmd_choices6.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label6.Text.ToString();
            cmd_choices6.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices6.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices6.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices6.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices6.ExecuteScalar();
            radioButton21.Text = Convert.ToString(cmd_choices6.Parameters["@1st_choice"].Value.ToString());
            radioButton22.Text = Convert.ToString(cmd_choices6.Parameters["@2nd_choice"].Value.ToString());
            radioButton23.Text = Convert.ToString(cmd_choices6.Parameters["@3rd_choice"].Value.ToString());
            radioButton24.Text = Convert.ToString(cmd_choices6.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices7 = new SqlCommand("question_choices_proc", conn);
            cmd_choices7.CommandType = storedProcedure;
            cmd_choices7.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label7.Text.ToString();
            cmd_choices7.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices7.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices7.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices7.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices7.ExecuteScalar();
            radioButton25.Text = Convert.ToString(cmd_choices7.Parameters["@1st_choice"].Value.ToString());
            radioButton26.Text = Convert.ToString(cmd_choices7.Parameters["@2nd_choice"].Value.ToString());
            radioButton27.Text = Convert.ToString(cmd_choices7.Parameters["@3rd_choice"].Value.ToString());
            radioButton28.Text = Convert.ToString(cmd_choices7.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices8 = new SqlCommand("question_choices_proc", conn);
            cmd_choices8.CommandType = storedProcedure;
            cmd_choices8.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label8.Text.ToString();
            cmd_choices8.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices8.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices8.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices8.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices8.ExecuteScalar();
            radioButton29.Text = Convert.ToString(cmd_choices8.Parameters["@1st_choice"].Value.ToString());
            radioButton30.Text = Convert.ToString(cmd_choices8.Parameters["@2nd_choice"].Value.ToString());
            radioButton31.Text = Convert.ToString(cmd_choices8.Parameters["@3rd_choice"].Value.ToString());
            radioButton32.Text = Convert.ToString(cmd_choices8.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices9 = new SqlCommand("question_choices_proc", conn);
            cmd_choices9.CommandType = storedProcedure;
            cmd_choices9.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label9.Text.ToString();
            cmd_choices9.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices9.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices9.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices9.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices9.ExecuteScalar();
            radioButton33.Text = Convert.ToString(cmd_choices9.Parameters["@1st_choice"].Value.ToString());
            radioButton34.Text = Convert.ToString(cmd_choices9.Parameters["@2nd_choice"].Value.ToString());
            radioButton35.Text = Convert.ToString(cmd_choices9.Parameters["@3rd_choice"].Value.ToString());
            radioButton36.Text = Convert.ToString(cmd_choices9.Parameters["@4th_choice"].Value.ToString());
            SqlCommand cmd_choices10 = new SqlCommand("question_choices_proc", conn);
            cmd_choices10.CommandType = storedProcedure;
            cmd_choices10.Parameters.Add("@label", SqlDbType.VarChar, 200).Value = label10.Text.ToString();
            cmd_choices10.Parameters.Add("@1st_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices10.Parameters.Add("@2nd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices10.Parameters.Add("@3rd_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices10.Parameters.Add("@4th_choice", SqlDbType.NVarChar, 50).Direction = ParameterDirection.Output;
            cmd_choices10.ExecuteScalar();
            radioButton37.Text = Convert.ToString(cmd_choices10.Parameters["@1st_choice"].Value.ToString());
            radioButton38.Text = Convert.ToString(cmd_choices10.Parameters["@2nd_choice"].Value.ToString());
            radioButton39.Text = Convert.ToString(cmd_choices10.Parameters["@3rd_choice"].Value.ToString());
            radioButton40.Text = Convert.ToString(cmd_choices10.Parameters["@4th_choice"].Value.ToString());
            conn.Close();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
                submitted_answer1 = radioButton1.Text;
            if (radioButton2.Checked)
                submitted_answer1 = radioButton2.Text;
            if (radioButton3.Checked)
                submitted_answer1 = radioButton3.Text;
            if (radioButton4.Checked)
                submitted_answer1 = radioButton4.Text;
            if (radioButton5.Checked)
                submitted_answer2 = radioButton5.Text;
            if (radioButton6.Checked)
                submitted_answer2 = radioButton6.Text;
            if (radioButton7.Checked)
                submitted_answer2 = radioButton7.Text;
            if (radioButton8.Checked)
                submitted_answer2 = radioButton8.Text;
            if (radioButton9.Checked)
                submitted_answer3 = radioButton9.Text;
            if (radioButton10.Checked)
                submitted_answer3 = radioButton10.Text;
            if (radioButton11.Checked)
                submitted_answer3 = radioButton11.Text;
            if (radioButton12.Checked)
                submitted_answer3 = radioButton12.Text;
            if (radioButton13.Checked)
                submitted_answer4 = radioButton13.Text;
            if (radioButton14.Checked)
                submitted_answer4 = radioButton14.Text;
            if (radioButton15.Checked)
                submitted_answer4 = radioButton15.Text;
            if (radioButton16.Checked)
                submitted_answer4 = radioButton16.Text;
            if (radioButton17.Checked)
                submitted_answer5 = radioButton17.Text;
            if (radioButton18.Checked)
                submitted_answer5 = radioButton18.Text;
            if (radioButton19.Checked)
                submitted_answer5 = radioButton19.Text;
            if (radioButton20.Checked)
                submitted_answer5 = radioButton20.Text;
            if (radioButton21.Checked)
                submitted_answer6 = radioButton21.Text;
            if (radioButton22.Checked)
                submitted_answer6 = radioButton22.Text;
            if (radioButton23.Checked)
                submitted_answer6 = radioButton23.Text;
            if (radioButton24.Checked)
                submitted_answer6 = radioButton24.Text;
            if (radioButton25.Checked)
                submitted_answer7 = radioButton25.Text;
            if (radioButton26.Checked)
                submitted_answer7 = radioButton26.Text;
            if (radioButton27.Checked)
                submitted_answer7 = radioButton27.Text;
            if (radioButton28.Checked)
                submitted_answer7 = radioButton28.Text;
            if (radioButton29.Checked)
                submitted_answer8 = radioButton29.Text;
            if (radioButton30.Checked)
                submitted_answer8 = radioButton30.Text;
            if (radioButton31.Checked)
                submitted_answer8 = radioButton31.Text;
            if (radioButton32.Checked)
                submitted_answer8 = radioButton32.Text;
            if (radioButton33.Checked)
                submitted_answer9 = radioButton33.Text;
            if (radioButton34.Checked)
                submitted_answer9 = radioButton34.Text;
            if (radioButton35.Checked)
                submitted_answer9 = radioButton35.Text;
            if (radioButton36.Checked)
                submitted_answer9 = radioButton36.Text;
            if (radioButton37.Checked)
                submitted_answer10 = radioButton37.Text;
            if (radioButton38.Checked)
                submitted_answer10 = radioButton38.Text;
            if (radioButton39.Checked)
                submitted_answer10 = radioButton39.Text;
            if (radioButton40.Checked)
                submitted_answer10 = radioButton40.Text;
            SqlConnection conn2 = new SqlConnection("Data Source=.;Initial Catalog=Examination_System;Integrated Security=True");
            SqlCommand saving_exam_id = new SqlCommand("saving_exam_id'"+ exam_id + "'", conn2);
            SqlCommand saving_ques1 = new SqlCommand("saving_ques'" + label1.Text + "','" + submitted_answer1 + "'", conn2);
            SqlCommand saving_ques2 = new SqlCommand("saving_ques'" + label2.Text + "','" + submitted_answer2 + "'", conn2);
            SqlCommand saving_ques3 = new SqlCommand("saving_ques'" + label3.Text + "','" + submitted_answer3 + "'", conn2);
            SqlCommand saving_ques4 = new SqlCommand("saving_ques'" + label4.Text + "','" + submitted_answer4 + "'", conn2);
            SqlCommand saving_ques5 = new SqlCommand("saving_ques'" + label5.Text + "','" + submitted_answer5 + "'", conn2);
            SqlCommand saving_ques6 = new SqlCommand("saving_ques'" + label6.Text + "','" + submitted_answer6 + "'", conn2);
            SqlCommand saving_ques7 = new SqlCommand("saving_ques'" + label7.Text + "','" + submitted_answer7 + "'", conn2);
            SqlCommand saving_ques8 = new SqlCommand("saving_ques'" + label8.Text + "','" + submitted_answer8 + "'", conn2);
            SqlCommand saving_ques9 = new SqlCommand("saving_ques'" + label9.Text + "','" + submitted_answer9 + "'", conn2);
            SqlCommand saving_ques10 = new SqlCommand("saving_ques'" + label10.Text + "','" + submitted_answer10 + "'", conn2);
            conn2.Open();
            saving_exam_id.ExecuteNonQuery();
            saving_ques1.ExecuteNonQuery();
            saving_ques2.ExecuteNonQuery();
            saving_ques3.ExecuteNonQuery();
            saving_ques4.ExecuteNonQuery();
            saving_ques5.ExecuteNonQuery();
            saving_ques6.ExecuteNonQuery();
            saving_ques7.ExecuteNonQuery();
            saving_ques8.ExecuteNonQuery();
            saving_ques9.ExecuteNonQuery();
            saving_ques10.ExecuteNonQuery();
            conn2.Close();
            this.Hide();
            scoreform ss = new scoreform();
            ss.Show();
        }

        private void SQLExam_Load(object sender, EventArgs e)
        {

        }
    }
}
