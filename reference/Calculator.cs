using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace calc
{
    public partial class Calculator : Form
    {
        StringBuilder builder = new StringBuilder();
        decimal previous = 0;
        decimal current = 0;
        bool set = false;
        char operation = (char)0;

        public Calculator()
        {
            InitializeComponent();
            this.KeyPreview = true;
            this.AcceptButton = this.button17;
        }

        private void Calculator_Load(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }


        private void textBox1_PreviewKeyDown(object sender, PreviewKeyDownEventArgs e)
        {
            e.IsInputKey = true;            
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            //e.Handled = true;
        }

        private void textBox1_KeyUp(object sender, KeyEventArgs e)
        {            
            
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            string st = "0123456789.+-/*\r" + (char)8;
            string st2 = "\r+-/*";
            if (st.IndexOf(e.KeyChar) == -1)
            {
                e.Handled = true;
            }
            else if(st2.IndexOf(e.KeyChar) != -1)
            {
                decimal current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);

                if( operation != 0)
                {
                    label2.Text = string.Empty;
                    switch (operation)
                    {
                        case '+':
                            label2.Text = (previous + current).ToString();
                            builder.Append("+");
                            builder.Append(current);
                            break;
                        case '-':
                            label2.Text = (previous - current).ToString();
                            builder.Append("-");
                            builder.Append(current);
                            break;
                        case '*':
                            label2.Text = (previous * current).ToString();
                            builder.Append("*");
                            builder.Append(current);
                            break;
                        case '/':
                            label2.Text = (previous / current).ToString();
                            builder.Append("/");
                            builder.Append(current);
                            break;
                    }

                    label2.Text = builder.ToString();
                    operation = st2[st2.IndexOf(e.KeyChar)];
                    e.Handled = true;
                    previous = current;
                }
                else
                {
                    label1.Text = builder.ToString();
                    label2.Text = string.Empty;
                    operation = st2[st2.IndexOf(e.KeyChar)];
                    e.Handled = true;
                    previous = current;
                }
            }
            else
            {

            }
        }

        private void label1_PreviewKeyDown(object sender, PreviewKeyDownEventArgs e)
        {
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "1");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "2");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "3");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "4");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "5");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "6");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }


        private void button9_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "7");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button8_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "8");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "9");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }


        private void button14_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = label2.Text.Contains(".") ? label2.Text : string.Concat(label2.Text, ".");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button13_Click(object sender, EventArgs e)
        {
            label2.Text = object.ReferenceEquals(label2.Tag, this) ? "0" : label2.Text;
            label2.Text = string.Concat(label2.Text, "0");
            label2.Text = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            label2.Tag = null;
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button19_Click(object sender, EventArgs e)
        {
            label2.Text = label2.Text.Substring(0, label2.Text.Length - 1);
            label2.Text = label2.Text == string.Empty ? "0" : decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any).ToString();
            current = decimal.Parse(label2.Text, System.Globalization.NumberStyles.Any);
            set = true;
        }

        private void button10_Click(object sender, EventArgs e)
        {
            Perform(sender, e);
            operation = '+';
            UpateStack(operation, operation, set, previous, current);
            set = false;
        }

        private void button11_Click(object sender, EventArgs e)
        {
            Perform(sender, e);
            operation = '-';
            UpateStack(operation, operation, set, previous, current);
            set = false;
        }

        private void button12_Click(object sender, EventArgs e)
        {
            Perform(sender, e);
            operation = '*';
            UpateStack(operation, operation, set, previous, current);
            set = false;
        }

        private void button16_Click(object sender, EventArgs e)
        {
            Perform(sender, e);
            operation = '/';
            UpateStack(operation, operation, set, previous, current);
            set = false;
        }

        private void button17_Click(object sender, EventArgs e)
        {
            Perform(sender, e);
            UpateStack('=', operation, set, previous, current);
            set = false;
        }


        private void Perform(object sender, EventArgs e)
        {
            if (sender != button17 && set == true)
            {
                PerformOperand(operation, previous, current, out previous);
                label2.Text = previous.ToString();
                label2.Tag = this;
            }
            else if (sender == button17 )
            {
                PerformOperand(operation, previous, current, out previous);
                label2.Text = previous.ToString();
                label2.Tag = this;
            }
        }

        private void UpateStack(char operation, char last, bool set, decimal previous, decimal current)
        {
            if (operation == '+' || operation == '-' || operation == '*' || operation == '/')
            {
                if( set )
                {
                    builder.Append(current.ToString());
                    builder.Append(" ");
                    builder.Append(operation);
                    builder.Append(" ");
                }
                else
                {
                    builder.Remove(builder.Length - 3, 3);
                    builder.Append(" ");
                    builder.Append(operation);
                    builder.Append(" ");
                }


                label1.Text = builder.ToString();
                label2.Tag = this;
                label2.Text = previous.ToString();
            }
            else if (operation == '=')
            {
                if (last != '=')
                {                   
                    builder.Clear();
                    builder.Append(previous.ToString());
                    builder.Append(" ");
                    builder.Append(last);
                    builder.Append(" ");
                    builder.Append(current.ToString());
                    builder.Append(" ");
                    builder.Append("=");
                    builder.Append(" ");
                }
                else
                {
                    builder.Clear();
                    builder.Append(previous.ToString());
                    builder.Append(" ");
                    builder.Append(last);
                    builder.Append(" ");
                }


                label1.Text = builder.ToString();
                label2.Tag = this;
                label2.Text = previous.ToString();
            }
        }

        private void PerformOperand(char operation, decimal a, decimal b, out decimal c)
        {
            if (operation == '+')
            {
                c = a + b;
            }

            else if (operation == '-')
            {
                c = a - b;
            }

            else if (operation == '*')
            {
                c = a * b;
            }

            else if (operation == '/')
            {
                try
                {
                    c = a / b;
                }
                catch (DivideByZeroException ex)
                {
                    c = 0;
                }
            }
            else
            {
                c = b;
            }
        }

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == Keys.Return)
            {
                button17.Focus();
                button17.PerformClick();
                return true;
            }
            else
            {
                return base.ProcessCmdKey(ref msg, keyData);
            }
        }

        protected override void OnPreviewKeyDown(PreviewKeyDownEventArgs e)
        {
            if( e.KeyCode == Keys.Return )
            {
                e.IsInputKey = true;
            }
        }

        protected override void OnKeyDown(KeyEventArgs e)
        {
            e.Handled = true;

            if( e.KeyCode == Keys.Escape )
            {
                Close();
            }

            if (e.KeyCode == Keys.F4 && e.Modifiers == Keys.Alt)
            {
                Close();
            }

            if (e.KeyCode == Keys.Delete)
            {
                button18.Focus();
                button18.PerformClick();
            }

            if( e.KeyCode == Keys.Decimal)
            {
                button14.Focus();
                button14.PerformClick();
            }

            if (e.KeyCode == Keys.Back)
            {
                button19.Focus();
                button19.PerformClick();
            }

            if( e.KeyCode == Keys.Add )
            {
                button10.Focus();
                button10.PerformClick();
            }

            if (e.KeyCode == Keys.Subtract)
            {
                button11.Focus();
                button11.PerformClick();
            }

            if (e.KeyCode == Keys.Multiply)
            {
                button12.Focus();
                button12.PerformClick();
            }

            if (e.KeyCode == Keys.Divide)
            {
                button16.Focus();
                button16.PerformClick();
            }


            if ( e.KeyCode == Keys.Return)
            {
                button17.Focus();
                button17.PerformClick();
            }

            if (e.KeyCode == Keys.D1 || e.KeyCode == Keys.NumPad1)
            {
                button1.Focus();
                button1.PerformClick();
            }

            if (e.KeyCode == Keys.D2 || e.KeyCode == Keys.NumPad2)
            {
                button2.Focus();
                button2.PerformClick();
            }

            if (e.KeyCode == Keys.D3 || e.KeyCode == Keys.NumPad3)
            {
                button3.Focus();
                button3.PerformClick();
            }

            if (e.KeyCode == Keys.D4 || e.KeyCode == Keys.NumPad4)
            {
                button6.Focus();
                button6.PerformClick();
            }

            if (e.KeyCode == Keys.D5 || e.KeyCode == Keys.NumPad5)
            {
                button5.Focus();
                button5.PerformClick();
            }

            if (e.KeyCode == Keys.D6 || e.KeyCode == Keys.NumPad6)
            {
                button4.Focus();
                button4.PerformClick();
            }

            if (e.KeyCode == Keys.D7 || e.KeyCode == Keys.NumPad7)
            {
                button9.Focus();
                button9.PerformClick();
            }

            if (e.KeyCode == Keys.D8 || e.KeyCode == Keys.NumPad8)
            {
                button8.Focus();
                button8.PerformClick();
            }

            if (e.KeyCode == Keys.D9 || e.KeyCode == Keys.NumPad9)
            {
                button7.Focus();
                button7.PerformClick();
            }


            if (e.KeyCode == Keys.D0 || e.KeyCode == Keys.NumPad0)
            {
                button13.Focus();
                button13.PerformClick();
            }
        }

        protected override void OnKeyPress(KeyPressEventArgs e)
        {
           e.Handled = true;
        }

        protected override void OnKeyUp(KeyEventArgs e)
        {
            e.Handled = true;
        }

        private void button15_Click(object sender, EventArgs e)
        {
            current = 0;
            previous = 0;
            operation = '=';
            label1.Text = string.Empty;
            label2.Text = "0";
            label2.Tag = this;
            builder.Clear();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button18_Click(object sender, EventArgs e)
        {
            label2.Text = "0";
            current = 0;
            set = false;
        }
    }
}
