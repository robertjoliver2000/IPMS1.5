//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.2.1       CA          23/06/2007      Del 90
//      1.7.1       GMcF        21/08/2007      Deliverable 95 - RTB Existing governance functionality
//      1.7.3       GMcF        30/08/2007      Deliverable 95 - RTB Existing governance functionality
//                                              RTBX GTO and RTBX Business direct to have separate "No records" option
//      2007-10-16  GMcF        2007-10-16      For HW request to add column CustomGrouping to table InitiativeFinancial
//
//*****************************************************************************************************

using System;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{
    /// <summary>
    /// Summary description for SectionC
    /// </summary>
    public class SectionC_DB
    {

        public static int InsertInitiativeFinancial(
                            int intIntiativeID,     
                            string strCategory, int intCategoryID, 
                            string strType, int intTypeID,  
                            string strDescription, int intDescriptionID,    
                            string strComments, 
                            int intOwnerID, 
                            string strBusinessGTLevel5Name,
                            string strBusinessGTLevel5Code,
                            string strBusinessGTLevel6Name,
                            string strBusinessGTLevel6Code,
                            string strBusinessGTLevel7Name,
                            string strBusinessGTLevel7Code,
                            string strBusinessGTLevel8Name,
                            string strBusinessGTLevel8Code,
                            string strBusinessGTLevel9Name,
                            string strBusinessGTLevel9Code,
                            string strBusinessGTLevel10Name,
                            string strBusinessGTLevel10Code,
                            string strCustomGrouping,           // Rev 2007-10-16, GMcF
                            int intUBR_ID,
                            object dtStartDate)
        {
            int intInitiativeFinancialID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertInitiativeFinancial = new SqlCommand();
            cmdInsertInitiativeFinancial.Connection = dbConnection;
            cmdInsertInitiativeFinancial.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdInsertInitiativeFinancial.CommandType = CommandType.StoredProcedure;
            cmdInsertInitiativeFinancial.CommandText = "spInsertInitiative_SectionC_Financial";

            cmdInsertInitiativeFinancial.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdInsertInitiativeFinancial.Parameters.Add("@Category", strCategory);
            cmdInsertInitiativeFinancial.Parameters.Add("@CategoryID", intCategoryID);
            cmdInsertInitiativeFinancial.Parameters.Add("@Type", strType);
            cmdInsertInitiativeFinancial.Parameters.Add("@TypeID", intTypeID);
            cmdInsertInitiativeFinancial.Parameters.Add("@Description", strDescription);
            cmdInsertInitiativeFinancial.Parameters.Add("@DescriptionID", intDescriptionID);
            cmdInsertInitiativeFinancial.Parameters.Add("@Comments", strComments);
            cmdInsertInitiativeFinancial.Parameters.Add("@OwnerID", intOwnerID);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel5Name", strBusinessGTLevel5Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel5Code", strBusinessGTLevel5Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel6Name", strBusinessGTLevel6Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel6Code", strBusinessGTLevel6Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel7Name", strBusinessGTLevel7Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel7Code", strBusinessGTLevel7Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel8Name", strBusinessGTLevel8Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel8Code", strBusinessGTLevel8Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel9Name", strBusinessGTLevel9Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel9Code", strBusinessGTLevel9Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel10Name", strBusinessGTLevel10Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel10Code", strBusinessGTLevel10Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@CustomGrouping", strCustomGrouping);    // Rev 2007-10-16, GMcF
            cmdInsertInitiativeFinancial.Parameters.Add("@UBR_ID", intUBR_ID);
            cmdInsertInitiativeFinancial.Parameters.Add("@StartDate", dtStartDate);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertInitiativeFinancial.Parameters.Add(parmReturnValue);

            dbConnection.Open();
            cmdInsertInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intInitiativeFinancialID = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intInitiativeFinancialID = -1;
            }

            return intInitiativeFinancialID;

        }


        public static int InsertInitiativeFinancialDepreciation(
                    int intIntiativeID,
                    string strCategory, int intCategoryID,
                    string strType, 
                    string strDescription, int intDescriptionID,
                    string strBusinessGTLevel5Name,
                    string strBusinessGTLevel5Code,
                    string strBusinessGTLevel6Name,
                    string strBusinessGTLevel6Code,
                    string strBusinessGTLevel7Name,
                    string strBusinessGTLevel7Code,
                    string strBusinessGTLevel8Name,
                    string strBusinessGTLevel8Code,
                    string strBusinessGTLevel9Name,
                    string strBusinessGTLevel9Code,
                    string strBusinessGTLevel10Name,
                    string strBusinessGTLevel10Code,
                    string strCustomGrouping,
                    int intUBR_ID,
                    object dtStartDate,
                    int intCapexFinancialID
                    )
        {
            int intInitiativeFinancialID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertInitiativeFinancial = new SqlCommand();
            cmdInsertInitiativeFinancial.Connection = dbConnection;
            cmdInsertInitiativeFinancial.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdInsertInitiativeFinancial.CommandType = CommandType.StoredProcedure;
            cmdInsertInitiativeFinancial.CommandText = "spInsertInitiative_SectionC_Financial_InsertDepreciation";

            cmdInsertInitiativeFinancial.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdInsertInitiativeFinancial.Parameters.Add("@Category", strCategory);
            cmdInsertInitiativeFinancial.Parameters.Add("@CategoryID", intCategoryID);
            cmdInsertInitiativeFinancial.Parameters.Add("@Type", strType);            
            cmdInsertInitiativeFinancial.Parameters.Add("@Description", strDescription);
            cmdInsertInitiativeFinancial.Parameters.Add("@DescriptionID", intDescriptionID);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel5Name", strBusinessGTLevel5Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel5Code", strBusinessGTLevel5Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel6Name", strBusinessGTLevel6Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel6Code", strBusinessGTLevel6Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel7Name", strBusinessGTLevel7Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel7Code", strBusinessGTLevel7Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel8Name", strBusinessGTLevel8Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel8Code", strBusinessGTLevel8Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel9Name", strBusinessGTLevel9Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel9Code", strBusinessGTLevel9Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel10Name", strBusinessGTLevel10Name);
            cmdInsertInitiativeFinancial.Parameters.Add("@BusinessGTLevel10Code", strBusinessGTLevel10Code);
            cmdInsertInitiativeFinancial.Parameters.Add("@CustomGrouping", strCustomGrouping);
            cmdInsertInitiativeFinancial.Parameters.Add("@UBR_ID", intUBR_ID);
            cmdInsertInitiativeFinancial.Parameters.Add("@StartDate", dtStartDate);
            cmdInsertInitiativeFinancial.Parameters.Add("@CapexFinancialID", intCapexFinancialID);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertInitiativeFinancial.Parameters.Add(parmReturnValue);

            dbConnection.Open();
            cmdInsertInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intInitiativeFinancialID = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intInitiativeFinancialID = -1;
            }

            return intInitiativeFinancialID;

        }

        public static void DeleteInitiativeFinancialDepreciation(int intInitiativeID, int intDepreciationFinancialID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeFinancial = new SqlCommand();
            cmdUpdateInitiativeFinancial.Connection = dbConnection;

            cmdUpdateInitiativeFinancial.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeFinancial.CommandText = "spDeleteInitiative_SectionC_Financial_Depreciation";

            cmdUpdateInitiativeFinancial.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@DepreciationFinancialID", intDepreciationFinancialID);            

            dbConnection.Open();
            cmdUpdateInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();
        }

        public static int UpdateInitiativeFinancial(
                            int intInitiativeFinancialID, int intIntiativeID, 
                            string strCategory, int intCategoryID,
                            string strType, int intTypeID,
                            string strDescription, int intDescriptionID,
                            string strComments,
                            int intOwnerID, 
                            string strBusinessGTLevel5Name,
                            string strBusinessGTLevel5Code,
                            string strBusinessGTLevel6Name,
                            string strBusinessGTLevel6Code,
                            string strBusinessGTLevel7Name,
                            string strBusinessGTLevel7Code,
                            string strBusinessGTLevel8Name,
                            string strBusinessGTLevel8Code,
                            string strBusinessGTLevel9Name,
                            string strBusinessGTLevel9Code,
                            string strBusinessGTLevel10Name,
                            string strBusinessGTLevel10Code,
                            string strCustomGrouping,           // Rev 2007-10-16, GMcF
                            int intUBR_ID,
                            object dtStartDate)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeFinancial = new SqlCommand();
            cmdUpdateInitiativeFinancial.Connection = dbConnection;

            cmdUpdateInitiativeFinancial.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeFinancial.CommandText = "spUpdateInitiative_SectionC_Financial";
            cmdUpdateInitiativeFinancial.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdUpdateInitiativeFinancial.Parameters.Add("@InitiativeFinancialID", intInitiativeFinancialID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@Category", strCategory);
            cmdUpdateInitiativeFinancial.Parameters.Add("@CategoryID", intCategoryID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@Type", strType);
            cmdUpdateInitiativeFinancial.Parameters.Add("@TypeID", intTypeID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@Description", strDescription);
            cmdUpdateInitiativeFinancial.Parameters.Add("@DescriptionID", intDescriptionID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@Comments", strComments);
            cmdUpdateInitiativeFinancial.Parameters.Add("@OwnerID", intOwnerID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel5Name", strBusinessGTLevel5Name);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel5Code", strBusinessGTLevel5Code);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel6Name", strBusinessGTLevel6Name);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel6Code", strBusinessGTLevel6Code);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel7Name", strBusinessGTLevel7Name);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel7Code", strBusinessGTLevel7Code);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel8Name", strBusinessGTLevel8Name);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel8Code", strBusinessGTLevel8Code);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel9Name", strBusinessGTLevel9Name);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel9Code", strBusinessGTLevel9Code);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel10Name", strBusinessGTLevel10Name);
            cmdUpdateInitiativeFinancial.Parameters.Add("@BusinessGTLevel10Code", strBusinessGTLevel10Code);
            cmdUpdateInitiativeFinancial.Parameters.Add("@CustomGrouping", strCustomGrouping);    // Rev 2007-10-16, GMcF
            cmdUpdateInitiativeFinancial.Parameters.Add("@UBR_ID", intUBR_ID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@StartDate", dtStartDate);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdUpdateInitiativeFinancial.Parameters.Add(parmReturnValue);

            dbConnection.Open();
            intRecordsAffected = cmdUpdateInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();

            return intRecordsAffected;
        }


        public static int UpdateInitiativeDepreciation(
                            int intInitiativeFinancialID, int intIntiativeID,
                            object dtStartDate)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeFinancial = new SqlCommand();
            cmdUpdateInitiativeFinancial.Connection = dbConnection;
            cmdUpdateInitiativeFinancial.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdUpdateInitiativeFinancial.CommandType = CommandType.Text;
            cmdUpdateInitiativeFinancial.CommandText = "UPDATE InitiativeFinancial SET StartDate=@StartDate " + 
                                    "WHERE InitiativeID=@InitiativeID AND InitiativeFinancialID=@InitiativeFinancialID";

            cmdUpdateInitiativeFinancial.Parameters.Add("@InitiativeFinancialID", intInitiativeFinancialID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdUpdateInitiativeFinancial.Parameters.Add("@StartDate", dtStartDate);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdUpdateInitiativeFinancial.Parameters.Add(parmReturnValue);

            dbConnection.Open();
            intRecordsAffected = cmdUpdateInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();

            return intRecordsAffected;
        }


        public static DataRow GetInitiativeFinancialDetails(int intInitiativeID, int intInitiativeFinancialID)
        {
            DataRow drInitiative = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;
            cmdGetInitiative.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT * FROM InitiativeFinancial " + 
                                                " WHERE InitiativeFinancial.InitiativeID=@InitiativeID AND InitiativeFinancial.InitiativeFinancialID=@InitiativeFinancialID";

            cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdGetInitiative.Parameters.Add("@InitiativeFinancialID", intInitiativeFinancialID);

            SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

            DataSet dsInitiative = new DataSet();

            try
            {
                daGetInitiative.Fill(dsInitiative, "Initiative");
            }
            catch (SqlException)
            {
                drInitiative = null;
            }

            if (dsInitiative.Tables["Initiative"] != null && dsInitiative.Tables["Initiative"].Rows.Count > 0)
            {
                drInitiative = dsInitiative.Tables["Initiative"].Rows[0];
            }

            return drInitiative;
        }

        public static DataSet GetInitiativeCapexDepreciations(int intCapexFinancialID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;            

            cmdGetDS.CommandText = "SELECT InitiativeFinancial.*, "+
                                "(SELECT SUM(Amount) FROM InitiativeValue WHERE ReferenceID = InitiativeFinancialID) AS DepreciationSum "+
                                "FROM InitiativeFinancial " +
                                "INNER JOIN CapexDepreciation ON InitiativeFinancial.InitiativeFinancialID = CapexDepreciation.DepreciationFinancialID " +
                                "WHERE CapexDepreciation.CapexFinancialID=@CapexFinancialID";

            cmdGetDS.Parameters.Add("@CapexFinancialID", intCapexFinancialID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Depreciations");

            return ds;
        }

        public static DataSet GetAllFinancialRecords(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            //cmdGetDS.CommandType = CommandType.Text;
            //cmdGetDS.CommandTimeout = Global_DB.SQLCommandTimeOut;

            //cmdGetDS.CommandText = "SELECT * FROM InitiativeFinancial " +
            //                    "WHERE InitiativeFinancial.InitiativeID=@InitiativeID";

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdGetDS.CommandText = "spGetAllFinancialRecords";

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
                //DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                //drNoRecords["CategoryID"] = 6;
                //drNoRecords["Type"] = "No records";

                //ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=7").ToString() == "0")
            {
                //DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                //drNoRecords["CategoryID"] = 7;
                //drNoRecords["Type"] = "No records";

                //ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
                //sectionc_db.sectionc.lblCapitalHardware.visible = false;
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=8").ToString() == "0")
            {
                //DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                //drNoRecords["CategoryID"] = 8;
                //drNoRecords["Type"] = "No records";

                //ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=11").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();                
                drNoRecords["CategoryID"] = 11;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=12").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();                
                drNoRecords["CategoryID"] = 12;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=13").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();                
                drNoRecords["CategoryID"] = 13;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=14").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();                
                drNoRecords["CategoryID"] = 14;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            //rev 1.2.1 CA
            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=15").ToString() == "0")
            {
                //****************start here!************
                //DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                //drNoRecords["CategoryID"] = 15;
                //drNoRecords["Type"] = "No records";

                //ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }
            //end rev 1.2.1

            // Rev 1.7.3, GMcF: Replaced by code below
            //// Rev 1.7.1 GMcF
            //if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID IN ( 9, 16, 17 )").ToString() == "0")
            //{
            //    DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
            //    drNoRecords["CategoryID"] = 16;
            //    drNoRecords["Type"] = "No records";

            //    ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            //}
            //// End Rev 1.7.1

            // Rev 1.7.3 GMcF RTBX GTO and RTBX Business direct to have separate "No records" option
            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID IN ( 9, 16 )").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 16;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }

            if (ds.Tables["FinancialRecords"].Compute("COUNT(InitiativeFinancialID)", "CategoryID=17").ToString() == "0")
            {
                DataRow drNoRecords = ds.Tables["FinancialRecords"].NewRow();
                drNoRecords["CategoryID"] = 17;
                drNoRecords["Type"] = "No records";

                ds.Tables["FinancialRecords"].Rows.Add(drNoRecords);
            }
            // End Rev 1.7.3

            return ds;
        }


        public static int InsertInitiativeValue(
                                    int intInitiativeFinancialID,
                                    int intInitiativeID,
                                    int intTypeID, 
                                    int intPeriodID,
                                    object objQuarterNo, 
                                    float fAmount
                                    )
        {
            int intReturnValue;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertInitiativeValue = new SqlCommand();
            cmdInsertInitiativeValue.Connection = dbConnection;

            cmdInsertInitiativeValue.CommandType = CommandType.StoredProcedure;
            cmdInsertInitiativeValue.CommandText = "spInsertInitiativeValue";
            cmdInsertInitiativeValue.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdInsertInitiativeValue.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdInsertInitiativeValue.Parameters.Add("@TypeID", intTypeID);
            cmdInsertInitiativeValue.Parameters.Add("@ReferenceID", intInitiativeFinancialID);
            cmdInsertInitiativeValue.Parameters.Add("@PeriodID", intPeriodID);
            cmdInsertInitiativeValue.Parameters.Add("@QuarterNo", objQuarterNo);
            cmdInsertInitiativeValue.Parameters.Add("@Amount", fAmount);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertInitiativeValue.Parameters.Add(parmReturnValue);

            dbConnection.Open();
            cmdInsertInitiativeValue.ExecuteNonQuery();
            dbConnection.Close();

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intReturnValue = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intReturnValue = -1;
            }

            return intReturnValue;
        }


        public static int UpdateInitiativeValue(
                                    int intInitiativeFinancialID,
                                    int intInitiativeID,
                                    int intTypeID,
                                    int intPeriodID,
                                    object objQuarterNo,
                                    float fAmount
                                    )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeValue = new SqlCommand();
            cmdUpdateInitiativeValue.Connection = dbConnection;

            cmdUpdateInitiativeValue.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeValue.CommandText = "spUpdateInitiativeValue";
            cmdUpdateInitiativeValue.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdUpdateInitiativeValue.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiativeValue.Parameters.Add("@TypeID", intTypeID);
            cmdUpdateInitiativeValue.Parameters.Add("@ReferenceID", intInitiativeFinancialID);
            cmdUpdateInitiativeValue.Parameters.Add("@PeriodID", intPeriodID);
            cmdUpdateInitiativeValue.Parameters.Add("@QuarterNo", objQuarterNo);
            cmdUpdateInitiativeValue.Parameters.Add("@Amount", fAmount);

            dbConnection.Open();
            intRecordsAffected = cmdUpdateInitiativeValue.ExecuteNonQuery();
            dbConnection.Close();

            return intRecordsAffected;
        }


        public static DataSet GetInitiativeValues(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiativeValues = new SqlCommand();
            cmdGetInitiativeValues.Connection = dbConnection;

            cmdGetInitiativeValues.CommandType = CommandType.Text;
            cmdGetInitiativeValues.CommandTimeout = Global_DB.SQLCommandTimeOut;
            cmdGetInitiativeValues.CommandText = "SELECT InitiativeFinancial.CategoryID, InitiativeFinancial.Type, InitiativeValue.* " + 
                                                    " FROM InitiativeFinancial " +
                                                    " JOIN InitiativeValue ON InitiativeFinancial.InitiativeFinancialID = InitiativeValue.ReferenceID " +
                                                " WHERE InitiativeFinancial.InitiativeID=@InitiativeID";

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

        // This compute 'PRE Year'
        // Required for Deliverable 81
        public static DataSet GetInitiativeValuesForDisplay(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiativeValues = new SqlCommand();
            cmdGetInitiativeValues.Connection = dbConnection;

            cmdGetInitiativeValues.CommandType = CommandType.Text;
            cmdGetInitiativeValues.CommandTimeout = Global_DB.SQLCommandTimeOut;
            //cmdGetInitiativeValues.CommandText = "SELECT InitiativeFinancial.CategoryID, InitiativeFinancial.Type, InitiativeValue.* " + 
            //                                        " FROM InitiativeFinancial " +
            //                                        " JOIN InitiativeValue ON InitiativeFinancial.InitiativeFinancialID = InitiativeValue.ReferenceID " +
            //                                    " WHERE InitiativeFinancial.InitiativeID=@InitiativeID";

            cmdGetInitiativeValues.CommandText = "SELECT * FROM [Initiative_GetInitiativeValue](@InitiativeID)";

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

        public static DataRow GetInitiativeDetails(int intInitiativeID)
        {
            DataRow drInitiative = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT * FROM Initiative WHERE InitiativeID=@InitiativeID";
            cmdGetInitiative.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

            DataSet dsInitiative = new DataSet();

            try
            {
                daGetInitiative.Fill(dsInitiative, "Initiative");
            }
            catch (SqlException)
            {
                drInitiative = null;
            }

            if (dsInitiative.Tables["Initiative"] != null && dsInitiative.Tables["Initiative"].Rows.Count > 0)
            {
                drInitiative = dsInitiative.Tables["Initiative"].Rows[0];
            }

            return drInitiative;
        }


        public static int UpdateInitiative(int intInitiativeID, 
                                        string strRTBAdditionalConsumption, int intRTBAdditionalConsumptionID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionC";
            cmdUpdateInitiative.CommandTimeout = Global_DB.SQLCommandTimeOut;


            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

            cmdUpdateInitiative.Parameters.Add("@RTBAdditionalConsumption", strRTBAdditionalConsumption);
            cmdUpdateInitiative.Parameters.Add("@RTBAdditionalConsumptionID", intRTBAdditionalConsumptionID);


            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }


        public static int DeleteInitiativeFinancial(
                             int intIntiativeID,
                             int intInitiativeFinancialID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDeleteInitiativeFinancial = new SqlCommand();
            cmdDeleteInitiativeFinancial.Connection = dbConnection;

            cmdDeleteInitiativeFinancial.CommandType = CommandType.StoredProcedure;
            cmdDeleteInitiativeFinancial.CommandText = "spDeleteInitiative_SectionC_Financial";
            cmdDeleteInitiativeFinancial.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdDeleteInitiativeFinancial.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdDeleteInitiativeFinancial.Parameters.Add("@InitiativeFinancialID", intInitiativeFinancialID);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdDeleteInitiativeFinancial.Parameters.Add(parmReturnValue);

            dbConnection.Open();
            intRecordsAffected = cmdDeleteInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();

            return intRecordsAffected;
        }



        public static int ClearInitiativeFinancial(
                                    int intIntiativeID,
                                    int intInitiativeFinancialID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdClearInitiativeFinancial = new SqlCommand();
            cmdClearInitiativeFinancial.Connection = dbConnection;
            cmdClearInitiativeFinancial.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdClearInitiativeFinancial.CommandType = CommandType.Text;
            cmdClearInitiativeFinancial.CommandText = "UPDATE InitiativeFinancial SET StartDate = NULL " + 
                                        "WHERE InitiativeID=@InitiativeID AND InitiativeFinancialID=@InitiativeFinancialID";

            cmdClearInitiativeFinancial.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdClearInitiativeFinancial.Parameters.Add("@InitiativeFinancialID", intInitiativeFinancialID);

            dbConnection.Open();
            intRecordsAffected = cmdClearInitiativeFinancial.ExecuteNonQuery();
            dbConnection.Close();

            return intRecordsAffected;
        }


        public static int ClearInitiativeFinancialValues(
                                           int intIntiativeID,
                                           int intInitiativeFinancialID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdClearInitiativeFinancialValues = new SqlCommand();
            cmdClearInitiativeFinancialValues.Connection = dbConnection;
            cmdClearInitiativeFinancialValues.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdClearInitiativeFinancialValues.CommandType = CommandType.Text;
            cmdClearInitiativeFinancialValues.CommandText = "UPDATE InitiativeValue SET Amount = 0 " +
                                        "WHERE InitiativeID=@InitiativeID AND TypeID=2 AND ReferenceID=@InitiativeFinancialID";

            cmdClearInitiativeFinancialValues.Parameters.Add("@InitiativeID", intIntiativeID);
            cmdClearInitiativeFinancialValues.Parameters.Add("@InitiativeFinancialID", intInitiativeFinancialID);

            dbConnection.Open();
            intRecordsAffected = cmdClearInitiativeFinancialValues.ExecuteNonQuery();
            dbConnection.Close();

            return intRecordsAffected;
        }


        public static int UpdateInitiative_AllRisks(int intInitiativeID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative_AllRisks = new SqlCommand();
            cmdUpdateInitiative_AllRisks.Connection = dbConnection;
            cmdUpdateInitiative_AllRisks.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdUpdateInitiative_AllRisks.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative_AllRisks.CommandText = "spUpdateInitiative_AllRisks";

            cmdUpdateInitiative_AllRisks.Parameters.Add("@InitiativeID", intInitiativeID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdateInitiative_AllRisks.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }


        public static int HasLegacyRTBExisting(int nInitiativeID)
        {
            int intResult;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;
            cmd.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spHasLegacyRTBExisting";

            cmd.Parameters.Add("@InitiativeID", nInitiativeID);

            try
            {
                dbConnection.Open();
                intResult = (int)cmd.ExecuteScalar();
            }
            catch (SqlException ex)
            {
                intResult = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intResult;
        }
    }
}
