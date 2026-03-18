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

public partial class ProjectsImport : System.Web.UI.Page
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
        OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [Spend$]", objConn);

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

        //Session["snBeenSaved"] = "BeingSaved";

        foreach (GridViewRow row in gvProjects.Rows)
        {
            
            //try
            //{
            //    dcTotalPlanLC = Convert.ToDecimal(row.Cells[8].Text);
            //}
            //catch (Exception e1)
            //{
            //    dcTotalPlanLC = 0;
            //}

            //try
            //{
            //    dcFXRate = Convert.ToDecimal(row.Cells[10].Text);
            //}
            //catch (Exception e1)
            //{
            //    dcFXRate = 0;
            //}

            //try
            //{
            //    dcAmountRequestedEUROs = Convert.ToDecimal(row.Cells[5].Text);
            //}
            //catch (Exception e1)
            //{
            //    dcAmountRequestedEUROs = 0;
            //}

            //try
            //{
            //    dcPercentRequired = (dcAmountRequestedEUROs / (dcTotalPlanLC * dcFXRate)) * 100;

            //}
            //catch (Exception e1)
            //{
            //    dcPercentRequired = 0;
            //}

            //try
            //{
            //    iProjectNo = SectionJ_DB.GetProjectNo(Convert.ToString(row.Cells[4].Text));

            //}
            //catch (Exception e1)
            //{
            //    iProjectNo = 0;
            //}

            //try
            //{
            //    iCurrencyNo = SectionJ_DB.GetCurrencyNo(Convert.ToString(row.Cells[9].Text));

            //}
            //catch (Exception e1)
            //{
            //    iCurrencyNo = 0;
            //}

            ProjectsImport.InsertInitiativeUpload(Convert.ToString(row.Cells[0].Text),
                                                Convert.ToString(row.Cells[1].Text),
                                                Convert.ToString(row.Cells[2].Text),
                                                Convert.ToString(row.Cells[3].Text),
                                                Convert.ToString(row.Cells[4].Text),
                                                Convert.ToDecimal(row.Cells[5].Text),
                                                Convert.ToDecimal(row.Cells[6].Text),
                                                Convert.ToDecimal(row.Cells[7].Text),
                                                Convert.ToDecimal(row.Cells[8].Text),
                                                Convert.ToDecimal(row.Cells[9].Text),
                                                Convert.ToDecimal(row.Cells[10].Text),
                                                Convert.ToDecimal(row.Cells[11].Text),
                                                Convert.ToDecimal(row.Cells[12].Text),
                                                Convert.ToDecimal(row.Cells[13].Text),
                                                Convert.ToDecimal(row.Cells[14].Text),
                                                Convert.ToDecimal(row.Cells[15].Text));
            
            //SectionJ_DB.InsertInitiativeProject(nInitiativeID,
            //                                    Convert.ToString(txtProjectID.Text),
            //                                    Convert.ToString(txtProjectName.Text),
            //                                    Convert.ToString(txtProjectDescr.Text),
            //                                    Convert.ToString(txtProgramName.Text),
            //                                    Convert.ToInt32(ddlProjectType.SelectedValue),
            //                                    ddlProjectType.SelectedItem.Text.ToString(),
            //                                    dcAmountRequestedEUROs,
            //                                    dcPercentRequired,
            //                                    dcTotalPlanLC,
            //                                    Convert.ToInt32(ddlBaseCurrency.SelectedValue),
            //                                    ddlBaseCurrency.SelectedItem.Text.ToString(),
            //                                    dcFXRate);

        }

        //RegisterStartupScript("closeScript",
        //    "<script language=JavaScript>  window.returnValue = 1; window.close();  </script>");
            
    }

    public static void InsertInitiativeUpload(string str0,
                                                string str1,
                                                string str2,
                                                string str3,
                                                string str4,
                                                decimal dc5,
                                                decimal dc6,
                                                decimal dc7,
                                                decimal dc8,
                                                decimal dc9,
                                                decimal dc10,
                                                decimal dc11,
                                                decimal dc12,
                                                decimal dc13,
                                                decimal dc14,
                                                decimal dc15)
    {
        SqlConnection dbConnection = new SqlConnection(ProjectsImport.GetConnectionString());

        SqlCommand cmdInsertInitiativeProject = new SqlCommand();
        cmdInsertInitiativeProject.Connection = dbConnection;

        cmdInsertInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProject.CommandText = "spInsertInitiative_Upload";

        cmdInsertInitiativeProject.Parameters.Add("@str0", str0);
        cmdInsertInitiativeProject.Parameters.Add("@str1", str1);
        cmdInsertInitiativeProject.Parameters.Add("@str2", str2);
        cmdInsertInitiativeProject.Parameters.Add("@str3", str3);
        cmdInsertInitiativeProject.Parameters.Add("@str4", str4);
        cmdInsertInitiativeProject.Parameters.Add("@dc5", dc5);
        cmdInsertInitiativeProject.Parameters.Add("@dc6", dc6);
        cmdInsertInitiativeProject.Parameters.Add("@dc7", dc7);
        cmdInsertInitiativeProject.Parameters.Add("@dc8", dc8);
        cmdInsertInitiativeProject.Parameters.Add("@dc9", dc9);
        cmdInsertInitiativeProject.Parameters.Add("@dc10", dc10);
        cmdInsertInitiativeProject.Parameters.Add("@dc11", dc11);
        cmdInsertInitiativeProject.Parameters.Add("@dc12", dc12);
        cmdInsertInitiativeProject.Parameters.Add("@dc13", dc13);
        cmdInsertInitiativeProject.Parameters.Add("@dc14", dc14);
        cmdInsertInitiativeProject.Parameters.Add("@dc15", dc15);



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
}
