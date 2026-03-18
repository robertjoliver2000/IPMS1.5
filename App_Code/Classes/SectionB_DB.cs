using System;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{
	/// <summary>
	/// Summary description for SectionB_DB.
	/// </summary>
	public class SectionB_DB
	{

        public static DataSet GetInitiativeValues(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiativeValues = new SqlCommand();
            cmdGetInitiativeValues.Connection = dbConnection;

            cmdGetInitiativeValues.CommandType = CommandType.Text;
            cmdGetInitiativeValues.CommandText = "SELECT InitiativeFinancial.CategoryID, InitiativeFinancial.Type, InitiativeValue.*, Period.Name AS Period " +
                                                   " FROM InitiativeFinancial " +
                                                  " JOIN InitiativeValue ON InitiativeFinancial.InitiativeFinancialID = InitiativeValue.ReferenceID " +
                                                   " JOIN Period On InitiativeValue.PeriodID = Period.PeriodID " + 
                                               " WHERE InitiativeFinancial.InitiativeID=@InitiativeID";

            // Required for Deliverable 81
            // *** RJO reversed out Deliverable 81 to try and restore
            //cmdGetInitiativeValues.CommandText = "SELECT * FROM [Initiative_GetInitiativeValue](@InitiativeID)";

            cmdGetInitiativeValues.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daGetInitiativeValues = new SqlDataAdapter(cmdGetInitiativeValues);

            DataSet dsInitiativeValues = new DataSet();

            try
            {
                daGetInitiativeValues.Fill(dsInitiativeValues, "InitiativeValue");
            }
            catch (SqlException)
            {
                dsInitiativeValues = null;
            }

            return dsInitiativeValues;
        }



        public static DataSet GetAllFinancialRecords(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;

            cmdGetDS.CommandText = "SELECT * FROM InitiativeFinancial " +
                                "WHERE InitiativeFinancial.InitiativeID=@InitiativeID";

            cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "FinancialRecords");

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=1").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 1;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=2").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 2;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=3").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 3;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=4").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 4;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=5").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 5;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=6").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 6;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=7").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 7;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=8").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 8;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            return ds;
        }

	}
}
