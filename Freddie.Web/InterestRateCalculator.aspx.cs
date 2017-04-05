using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Microsoft.AnalysisServices.AdomdClient;

namespace Freddie.Web
{
    public partial class InterestRateCalculator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            // get the values from the form
            string creditScore = tbCreditScore.Text;
            string loanToValue = tbLTV.Text;
            string monthlyIncome = tbIncome.Text;
            string monthlyDebt = tbDebt.Text;
            string loanAmount = tbAmount.Text;

            // calculate dti
            int dti = (int)((Convert.ToDouble(monthlyDebt) / Convert.ToDouble(monthlyIncome)) * 100);

            // construct the query string
            string dmx = @"SELECT PREDICT([Interest Rate]) 
                            FROM [InterestRate LR]
                            NATURAL PREDICTION JOIN
                            (SELECT " + creditScore + @" as [Credit Score]
                                , " + loanToValue + @"as [Original CTLV]
                                , " + dti.ToString() + @" as [Original DTI Ratio]
                                , " + loanAmount + @" as [Original UPB]
                            ) as t";

            // connect to ssas
            AdomdConnection conn = new AdomdConnection(@"Data Source=localhost\MD;Catalog=Freddie SSAS");
            conn.Open();

            AdomdCommand cmd = new AdomdCommand(dmx, conn);
            AdomdDataReader reader = cmd.ExecuteReader();
            reader.Read();
            double rate = (double)reader[0];

            conn.Close();

            lbInterestRate.Text = Math.Round(rate, 2).ToString();
        }
    }
}