using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.IO;

public partial class ProjectsImportUBR : System.Web.UI.Page
{
    string randomFilename;
    bool fileOK = false;
    DataSet dsProjects;
    protected int nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);

        try
        {
            //nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            //nInitiativeID = -1;
        }

        if (IsPostBack)
        {
            String path = Server.MapPath("~/import/");
            if (FileUpload1.HasFile)
            {
                String fileExtension =
                    System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                String[] allowedExtensions = 
                { ".xls" };
                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        fileOK = true;
                    }
                }

                if (fileOK)
                {
                    try
                    {
                        randomFilename = NewRandomString();
                        FileUpload1.PostedFile.SaveAs(path
                            + randomFilename + ".xls");
                        Label1.Text = "File uploaded!";
                    }
                    catch (Exception ex)
                    {
                        Label1.Text = "File could not be uploaded.";
                    }
                }
                else
                {
                    Label1.Text = "Cannot accept files of this type.";
                }
            }            
        }
    }

    private void LoadGridView()
    {
        // Create connection string variable. Modify the "Data Source"
        // parameter as appropriate for your environment.
        String sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
            "Data Source=" + Server.MapPath("import/" + randomFilename + ".xls") + ";" +
            "Extended Properties=Excel 8.0;";

        // Create connection object by using the preceding connection string.
        OleDbConnection objConn = new OleDbConnection(sConnectionString);

        Response.Write(sConnectionString);

        // Open connection with the database.
        objConn.Open();

        // The code to follow uses a SQL SELECT command to display the data from the worksheet.

        // Create new OleDbCommand to return data from worksheet.
        OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [Actions$]", objConn);

        // Create new OleDbDataAdapter that is used to build a DataSet
        // based on the preceding SQL SELECT statement.
        OleDbDataAdapter objAdapter1 = new OleDbDataAdapter();

        // Pass the Select command to the adapter.
        objAdapter1.SelectCommand = objCmdSelect;

        // Create new DataSet to hold information from the worksheet.
        dsProjects = new DataSet();

        // Fill the DataSet with the information from the worksheet.
        objAdapter1.Fill(dsProjects, "XLData");

        // Bind data to DataGrid control.
        gvProjects.DataSource = dsProjects.Tables[0].DefaultView;
        gvProjects.DataBind();

        // Clean up objects.
        objConn.Close();
        File.Delete(Server.MapPath("import/" + randomFilename + ".xls"));
    }

    protected void btnPopGrid_Click(object sender, EventArgs e)
    {
        if (fileOK)
        {
            LoadGridView();
            btnSaveProjects.Enabled = true;
            btnPopGrid.Enabled = false;
        }
    }

    private string NewRandomString()
    {
        System.Text.StringBuilder myCode = new System.Text.StringBuilder("");
        System.Random random = new Random(unchecked((int)DateTime.Now.Ticks));
        for (int i = 1; i <= 20; i++)
        {
            int c = (int)random.Next(65, 91);
            myCode.Append((char)c);
        }
        return myCode.ToString();
    }

    protected void gvProjects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvProjects.PageIndex = e.NewPageIndex;
        gvProjects.DataSource = dsProjects.Tables[0].DefaultView;
        gvProjects.DataBind();
    }

    protected void btnSaveProjects_Click(object sender, EventArgs e)
    {

        decimal dcPercentRequired, dcAmountRequestedEUROs, dcTotalPlanLC, dcFXRate;

        int iProjectNo;
        int iCurrencyNo;

        foreach (GridViewRow row in gvProjects.Rows)
        {

            //ProjectsImportUBR.InsertInitiativeUpload(Convert.ToString(row.Cells[0].Text),
            //                                    Convert.ToString(row.Cells[1].Text),
            //                                    Convert.ToString(row.Cells[2].Text),
            //                                    Convert.ToString(row.Cells[3].Text),
            //                                    Convert.ToString(row.Cells[4].Text),
            //                                    Convert.ToString(row.Cells[5].Text),
            //                                    Convert.ToString(row.Cells[6].Text),
            //                                    Convert.ToString(row.Cells[7].Text),
            //                                    Convert.ToString(row.Cells[8].Text),
            //                                    Convert.ToString(row.Cells[9].Text),
            //                                    Convert.ToString(row.Cells[10].Text),
            //                                    Convert.ToString(row.Cells[11].Text),
            //                                    Convert.ToString(row.Cells[12].Text));

            ProjectsImportUBR.InsertTmpUbrUpload(Convert.ToString(row.Cells[0].Text),
                                                Convert.ToString(row.Cells[1].Text),
                                                Convert.ToString(row.Cells[2].Text),
                                                Convert.ToString(row.Cells[3].Text),
                                                Convert.ToString(row.Cells[4].Text),
                                                Convert.ToString(row.Cells[5].Text),
                                                Convert.ToString(row.Cells[6].Text),
                                                Convert.ToString(row.Cells[7].Text),
                                                Convert.ToString(row.Cells[8].Text),
                                                Convert.ToString(row.Cells[9].Text),
                                                Convert.ToString(row.Cells[10].Text),
                                                Convert.ToString(row.Cells[11].Text),
                                                Convert.ToString(row.Cells[12].Text),
                                                Convert.ToString(row.Cells[13].Text),
                                                Convert.ToString(row.Cells[14].Text),
                                                Convert.ToString(row.Cells[15].Text)
                                                );

        }

    }

    public static void InsertTmpUbrUpload(string Level5Code,
                                            string Level5Name,
                                            string Level6Code,
                                            string Level6Name,
                                            string Level7Code,
                                            string Level7Name,
                                            string Level8Code,
                                            string Level8Name,
                                            string Level9Code,
                                            string Level9Name,
                                            string Level10Code,
                                            string Level10Name,
                                            string CustomGrouping,
                                            string action,
                                            string NewLevel10Code,
                                            string NewLevel10Name
        )

    {
        SqlConnection dbConnection = new SqlConnection(ProjectsImportUBR.GetConnectionString());

        SqlCommand cmdInsertInitiativeProject = new SqlCommand();
        cmdInsertInitiativeProject.Connection = dbConnection;

        cmdInsertInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProject.CommandText = "ubr_upload_insert_TMP_UBR_UPLOAD";

        cmdInsertInitiativeProject.Parameters.Add("@Level5Code", Level5Code);
        cmdInsertInitiativeProject.Parameters.Add("@Level5Name", Level5Name);
        cmdInsertInitiativeProject.Parameters.Add("@Level6Code", Level6Code);
        cmdInsertInitiativeProject.Parameters.Add("@Level6Name", Level6Name);
        cmdInsertInitiativeProject.Parameters.Add("@Level7Code", Level7Code);
        cmdInsertInitiativeProject.Parameters.Add("@Level7Name", Level7Name);
        cmdInsertInitiativeProject.Parameters.Add("@Level8Code", Level8Code);
        cmdInsertInitiativeProject.Parameters.Add("@Level8Name", Level8Name);
        cmdInsertInitiativeProject.Parameters.Add("@Level9Code", Level9Code);
        cmdInsertInitiativeProject.Parameters.Add("@Level9Name", Level9Name);
        cmdInsertInitiativeProject.Parameters.Add("@Level10Code", Level10Code);
        cmdInsertInitiativeProject.Parameters.Add("@Level10Name", Level10Name);
        cmdInsertInitiativeProject.Parameters.Add("@CustomGrouping", CustomGrouping);
        cmdInsertInitiativeProject.Parameters.Add("@action", action);
        cmdInsertInitiativeProject.Parameters.Add("@NewLevel10Code", NewLevel10Code);
        cmdInsertInitiativeProject.Parameters.Add("@NewLevel10Name", NewLevel10Name);
        try
        {
            dbConnection.Open();
            cmdInsertInitiativeProject.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }


    public static void InsertInitiativeUpload(string str0,
                                                string str1,
                                                string str2,
                                                string str3,
                                                string str4,
                                                string str5,
                                                string str6,
                                                string str7,
                                                string str8,
                                                string str9,
                                                string str10,
                                                string str11,
                                                string str12)

    {
        SqlConnection dbConnection = new SqlConnection(ProjectsImportUBR.GetConnectionString());

        SqlCommand cmdInsertInitiativeProject = new SqlCommand();
        cmdInsertInitiativeProject.Connection = dbConnection;

        cmdInsertInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProject.CommandText = "spInsertInitiative_UploadUBR";

        cmdInsertInitiativeProject.Parameters.Add("@str0", str0);
        cmdInsertInitiativeProject.Parameters.Add("@str1", str1);
        cmdInsertInitiativeProject.Parameters.Add("@str2", str2);
        cmdInsertInitiativeProject.Parameters.Add("@str3", str3);
        cmdInsertInitiativeProject.Parameters.Add("@str4", str4);
        cmdInsertInitiativeProject.Parameters.Add("@str5", str5);
        cmdInsertInitiativeProject.Parameters.Add("@str6", str6);
        cmdInsertInitiativeProject.Parameters.Add("@str7", str7);
        cmdInsertInitiativeProject.Parameters.Add("@str8", str8);
        cmdInsertInitiativeProject.Parameters.Add("@str9", str9);
        cmdInsertInitiativeProject.Parameters.Add("@str10", str10);
        cmdInsertInitiativeProject.Parameters.Add("@str11", str11);
        cmdInsertInitiativeProject.Parameters.Add("@str12", str12);

        try
        {
            dbConnection.Open();
            cmdInsertInitiativeProject.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }

    public static string GetConnectionString()
    {
        return ConfigurationSettings.AppSettings["connectionString"];
    }

    protected void btnPart1_Click(object sender, EventArgs e)
    {
        ProcessUBRUpload();

        //foreach (GridViewRow row in gvProjects.Rows)
        //{

        //    ProjectsImportUBR.InsertUBRUpload1(Convert.ToString(row.Cells[0].Text),
        //                                        Convert.ToString(row.Cells[1].Text),
        //                                        Convert.ToString(row.Cells[2].Text),
        //                                        Convert.ToString(row.Cells[3].Text),
        //                                        Convert.ToString(row.Cells[4].Text),
        //                                        Convert.ToString(row.Cells[5].Text),
        //                                        Convert.ToString(row.Cells[6].Text),
        //                                        Convert.ToString(row.Cells[7].Text),
        //                                        Convert.ToString(row.Cells[8].Text),
        //                                        Convert.ToString(row.Cells[9].Text),
        //                                        Convert.ToString(row.Cells[10].Text),
        //                                        Convert.ToString(row.Cells[11].Text),
        //                                        Convert.ToString(row.Cells[12].Text),
        //                                        Convert.ToString(row.Cells[13].Text),
        //                                        Convert.ToString(row.Cells[14].Text),
        //                                        Convert.ToString(row.Cells[15].Text));
        //}

    }



    public static void ProcessUBRUpload()
    {
        SqlConnection dbConnection = new SqlConnection(ProjectsImportUBR.GetConnectionString());

        SqlCommand cmd = new SqlCommand();
        cmd.Connection = dbConnection;

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "ubr_upload_process";

        try
        {
            dbConnection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }


    public static void InsertUBRUpload1(string str0,
                                            string str1,
                                            string str2,
                                            string str3,
                                            string str4,
                                            string str5,
                                            string str6,
                                            string str7,
                                            string str8,
                                            string str9,
                                            string str10,
                                            string str11,
                                            string str12,
                                            string str13,
                                            string str14,
                                            string str15)
    {
        SqlConnection dbConnection = new SqlConnection(ProjectsImportUBR.GetConnectionString());

        SqlCommand cmdInsertInitiativeProject = new SqlCommand();
        cmdInsertInitiativeProject.Connection = dbConnection;

        cmdInsertInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProject.CommandText = "spInsertInitiative_UploadUBR1";

        cmdInsertInitiativeProject.Parameters.Add("@str0", str0);
        cmdInsertInitiativeProject.Parameters.Add("@str1", str1);
        cmdInsertInitiativeProject.Parameters.Add("@str2", str2);
        cmdInsertInitiativeProject.Parameters.Add("@str3", str3);
        cmdInsertInitiativeProject.Parameters.Add("@str4", str4);
        cmdInsertInitiativeProject.Parameters.Add("@str5", str5);
        cmdInsertInitiativeProject.Parameters.Add("@str6", str6);
        cmdInsertInitiativeProject.Parameters.Add("@str7", str7);
        cmdInsertInitiativeProject.Parameters.Add("@str8", str8);
        cmdInsertInitiativeProject.Parameters.Add("@str9", str9);
        cmdInsertInitiativeProject.Parameters.Add("@str10", str10);
        cmdInsertInitiativeProject.Parameters.Add("@str11", str11);
        cmdInsertInitiativeProject.Parameters.Add("@str12", str12);
        cmdInsertInitiativeProject.Parameters.Add("@str13", str13);
        cmdInsertInitiativeProject.Parameters.Add("@str14", str14);
        cmdInsertInitiativeProject.Parameters.Add("@str15", str15);

        try
        {
            dbConnection.Open();
            cmdInsertInitiativeProject.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }

    protected void btnPart2_Click(object sender, EventArgs e)
    {
        int iInitiativeID;
        string sSearchText;

        foreach (GridViewRow row in gvProjects.Rows)
        {

            //start
            SqlConnection dbConnection = new SqlConnection(ProjectsImportUBR.GetConnectionString());

            SqlCommand cmdInitiativeID = new SqlCommand();
            cmdInitiativeID.Connection = dbConnection;

            cmdInitiativeID.CommandType = CommandType.Text;
            cmdInitiativeID.CommandText = "Select InitiativeID from Initiative WHERE Initiative.Name = @InitiativeID";

            sSearchText = Convert.ToString(row.Cells[2].Text);
            sSearchText = sSearchText.Replace("&amp;","&");

            cmdInitiativeID.Parameters.Add("@InitiativeID", sSearchText);

            SqlDataAdapter daInitiativeID = new SqlDataAdapter(cmdInitiativeID);

            DataSet dsInitiativeID = new DataSet();

            daInitiativeID.Fill(dsInitiativeID, "InitiativeID");

            foreach (DataRow drInitiativeID in dsInitiativeID.Tables["InitiativeID"].Rows)
            {
                if (drInitiativeID[0] != DBNull.Value)
                {
                    iInitiativeID = (int)drInitiativeID[0];
                }
                else
                {
                    iInitiativeID = 0;
                }
                //finish

                ProjectsImportUBR.InsertUBRUpload2(iInitiativeID,
                                               Convert.ToString(row.Cells[0].Text),
                                               Convert.ToString(row.Cells[1].Text),
                                               Convert.ToString(row.Cells[2].Text),
                                               Convert.ToString(row.Cells[3].Text));

            }
            
           
        }
    }

    public static void InsertUBRUpload2(int InitiativeID,
                                            string str0,
                                            string str1,
                                            string str2,
                                            string str3)
    {
        SqlConnection dbConnection = new SqlConnection(ProjectsImportUBR.GetConnectionString());

        SqlCommand cmdInsertInitiativeProject = new SqlCommand();
        cmdInsertInitiativeProject.Connection = dbConnection;

        cmdInsertInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProject.CommandText = "spInsertInitiative_UploadUBR2";

        cmdInsertInitiativeProject.Parameters.Add("@InitiativeID", InitiativeID);

        cmdInsertInitiativeProject.Parameters.Add("@str0", str0);
        cmdInsertInitiativeProject.Parameters.Add("@str1", str1);
        cmdInsertInitiativeProject.Parameters.Add("@str2", str2);
        cmdInsertInitiativeProject.Parameters.Add("@str3", str3);

        try
        {
            dbConnection.Open();
            cmdInsertInitiativeProject.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }

}
