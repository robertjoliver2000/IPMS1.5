//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.4       CA          07/02/2007     New Dynamic Header for Date
//                                              
//
//*****************************************************************************************************

using System;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.WebControls.Adapters;
using System.Web.UI.HtmlControls;

using System.Data.OleDb;
using System.IO;

public partial class Controls_SectionJ : System.Web.UI.UserControl

{
    protected int nInitiativeID;

    string randomFilename;
    bool fileOK = false;
    DataSet dsProjects;

    //rev 1.1.4 CA
    string dInitiativeYear;
    //end rev

    bool bHasBeenDownloaded;

    //rev 1.1.4 not required
    //protected System.Web.UI.WebControls.Label new07Header;
    //end rev

    protected void Page_Load(object sender, EventArgs e)
    {
        //rev 1.1.4 not required
        //new07Header = new Label();
        //new07Header.ID = "new07Header";
        //new07Header.Style["Position"] = "Absolute";
        //new07Header.Style["Top"] = "50px";
        //new07Header.Style["Left"] = "50px";
        //Controls.Add(new07Header);
        //end rev

        try
        {
            nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            nInitiativeID = -1;
        }

        btnAddProject.Attributes.Add("onclick", "javascript:popupWindowProject(" + nInitiativeID.ToString() + ",0)");
        btnAddMultipleProjects.Attributes.Add("onclick", "javascript:popupImportProjects(" + nInitiativeID.ToString() + ")");

        //rev 1.1.4
        if (Page.IsPostBack)
        {
            


            //Response.Redirect("~/default.aspx?section=4&InitiativeID=" + nInitiativeID.ToString());
            //LoadInitiative();
            //new07Header.Text = "big test";
        }
        //end rev

        //rev 1.1.4
        DataRow drInitiative = SectionJ_DB.GetInitiativeDetails(nInitiativeID);

        dInitiativeYear = drInitiative["SubmissionDate"].ToString();
        dInitiativeYear = dInitiativeYear.Substring(8, 2);
        //end rev

        BindRepeater();

    }

    public void BindRepeater()
    {
        repeaterProject.DataSource = SectionJ_DB.GetProjects(nInitiativeID);
        repeaterProject.DataBind();
    }


    public string GetIGAmountRequested()
    {
        decimal amount = SectionJ_DB.GetProjecTotals(nInitiativeID, "IGAmount");
        return amount.ToString("C");
    }

    public string GetTotalPlan()
    {
        decimal amount = SectionJ_DB.GetProjecTotals(nInitiativeID, "TotalPlan");
        return amount.ToString("C");
    }

    protected void repeaterProject_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
         //items

        //rem CA
        //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Header)
        //end rem

        //rev 1.1.4 CA
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Header)
        //end rev
        {
            ImageButton imgButt = (ImageButton)e.Item.FindControl("delProjectID");
            if (imgButt != null)
                imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this project?')) AllowOneTimeSubmit(); else return false; ");

            //rev 1.1.4 CA
            Label lblProjectID = (Label)e.Item.FindControl("lblProjectID");

            if (lblProjectID != null)
            {
                lblProjectID.Text = "Project ID";
            }

            Label lblProjectName = (Label)e.Item.FindControl("lblProjectName");

            if (lblProjectName != null)
            {
                lblProjectName.Text = "Project Name";
            }

            Label lblProjectDesc = (Label)e.Item.FindControl("lblProjectDesc");

            if (lblProjectDesc != null)
            {
                lblProjectDesc.Text = "Project Description";
            }

            Label lblProgramName = (Label)e.Item.FindControl("lblProgramName");

            if (lblProgramName != null)
            {
                lblProgramName.Text = "Program Name";
            }

            Label lblProjectType = (Label)e.Item.FindControl("lblProjectType");

            if (lblProjectType != null)
            {
                lblProjectType.Text = "Project Type";
            }

            Label lblIGAmount = (Label)e.Item.FindControl("lblIGAmount");

            if (lblIGAmount != null)
            {
                lblIGAmount.Text = "IG Amount Requested";
            }

            Label lblTotalEUR = (Label)e.Item.FindControl("lblTotalEUR");

            if (lblTotalEUR != null)
            {
                lblTotalEUR.Text = "Total Plan " + dInitiativeYear + " in EUR as per BEN 'PROVIDER VIEW'";
            }

            Label lblIGApproval = (Label)e.Item.FindControl("lblIGApproval");

            if (lblIGApproval != null)
            {
                lblIGApproval.Text = "If partial IG Approval is requested, % required";
            }

            Label lblTotalLocal = (Label)e.Item.FindControl("lblTotalLocal");

            if (lblTotalLocal != null)
            {
                lblTotalLocal.Text = "Total Plan " + dInitiativeYear + " in Local Currency as per BEN 'PROVIDER VIEW'";
            }

            Label lblBaseCurrency = (Label)e.Item.FindControl("lblBaseCurrency");

            if (lblBaseCurrency != null)
            {
                lblBaseCurrency.Text = "Base Currency as per BEN 'PROVIDER VIEW'";
            }

            Label lblFXRate = (Label)e.Item.FindControl("lblFXRate");

            if (lblFXRate != null)
            {
                lblFXRate.Text = "FX Rate used (for non - EURO projects)";
            }
            //end rev
        }

       
    }

    protected void repeaterProject_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int nProjectID;
        
        //items
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    nProjectID = Convert.ToInt32(e.CommandArgument);
                }
                catch (Exception e1)
                {
                    nProjectID = 0;
                }

                SectionJ_DB.DeleteInitiativeProject(nProjectID);
            }
        }

        BindRepeater();

    }

    private void DownloadFile(string fname, bool forceDownload)
    {
        string sPath = MapPath(fname);
        string sName = Path.GetFileName(sPath);
        string sExt = Path.GetExtension(sPath);
        string sType = "";

        bHasBeenDownloaded = true;

        // set known types based on file extension  
        if (sExt != null)
        {
            switch (sExt.ToLower())
            {
                case ".htm":
                case ".html":
                    sType = "text/HTML";
                    break;

                case ".txt":
                    sType = "text/plain";
                    break;

                case ".doc":
                case ".rtf":
                    sType = "Application/msword";
                    break;
            }
        }
        if (forceDownload)
        {
            Response.AppendHeader("content-disposition",
                "attachment; filename=" + sName);
        }
        if (sType != "")
            Response.ContentType = sType;
        Response.WriteFile(sPath);
        Response.End();
    }


    protected void DownLoadTemplate_Click(object sender, EventArgs e)
    {
        if ((string)Session["snBeenSaved"] != "BeingSaved")
        {
            //ERW 12 Mar 2009
            // changed to ProjectUploadTemplate
           // DownloadFile("~\\template\\exceltemplate.xls", true);
            DownloadFile("~\\template\\ProjectUploadTemplate.xls", true);
        }
     Session["snBeenSaved"] = "NotBeingSaved";  
    }
 
    protected void btnSaveProjects_Click(object sender, EventArgs e)
    {
        decimal dcPercentRequired, dcAmountRequestedEUROs, dcTotalPlanLC, dcFXRate;

        int iProjectNo;
        int iCurrencyNo;

        Session["snBeenSaved"] = "BeingSaved";

        foreach (GridViewRow row in gvProjects.Rows)
        {

            try
            {
                dcTotalPlanLC = Convert.ToDecimal(row.Cells[8].Text);
            }
            catch (Exception e1)
            {
                dcTotalPlanLC = 0;
            }

            try
            {
                dcFXRate = Convert.ToDecimal(row.Cells[10].Text);
            }
            catch (Exception e1)
            {
                dcFXRate = 0;
            }

            try
            {
                dcAmountRequestedEUROs = Convert.ToDecimal(row.Cells[5].Text);
            }
            catch (Exception e1)
            {
                dcAmountRequestedEUROs = 0;
            }

            try
            {
                dcPercentRequired = (dcAmountRequestedEUROs / (dcTotalPlanLC * dcFXRate)) * 100;

            }
            catch (Exception e1)
            {
                dcPercentRequired = 0;
            }

            try
            {
                iProjectNo = SectionJ_DB.GetProjectNo(Convert.ToString(row.Cells[4].Text));

            }
            catch (Exception e1)
            {
                iProjectNo = 0;
            }

            try
            {
                iCurrencyNo = SectionJ_DB.GetCurrencyNo(Convert.ToString(row.Cells[9].Text));

            }
            catch (Exception e1)
            {
                iCurrencyNo = 0;
            }

            SectionJ_DB.InsertInitiativeProject(nInitiativeID,
                                                Convert.ToString(row.Cells[0].Text),
                                                Convert.ToString(row.Cells[1].Text),
                                                Convert.ToString(row.Cells[2].Text),
                                                Convert.ToString(row.Cells[3].Text),
                                                iProjectNo,
                                                Convert.ToString(row.Cells[4].Text),
                                                dcAmountRequestedEUROs,
                                                dcPercentRequired,
                                                dcTotalPlanLC,
                                                iCurrencyNo,
                                                Convert.ToString(row.Cells[9].Text),
                                                dcFXRate);

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

        Response.Redirect("~/default.aspx?section=4&InitiativeID=" + nInitiativeID.ToString());

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

    protected void btnPopGrid_Click(object sender, EventArgs e)
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

        if (fileOK)
        {
            LoadGridView();
            btnSaveProjects.Enabled = true;
            btnPopGrid.Enabled = false;
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

        // Open connection with the database.
        objConn.Open();

        // The code to follow uses a SQL SELECT command to display the data from the worksheet.

        //ERW 21 Mar 2009
        //changed to read from the "Project" sheet
        // Create new OleDbCommand to return data from worksheet.
        //OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [Sheet2$]", objConn);
        OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [Project$]", objConn);
        

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
}
