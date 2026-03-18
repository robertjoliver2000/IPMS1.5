//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.7.1       GMcF        2007-08-20      Deliverable 95 - RTB existing governance functionality
//      2007-10-16  GMcF        2007-10-16      HW Request - add column CustomGrouping to table InitiativeFinancial
//
//*****************************************************************************************************

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
using ProjectPortfolio.Classes;


namespace ProjectPortfolio
{
    public partial class Financial : System.Web.UI.Page
    {

        protected int m_nInitiativeID;
        protected DataSet m_dsPeriod;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            try
            {
                m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                m_nInitiativeID = -1;
            }

            lnkStartDate.HRef = "#";
            lnkStartDate.Attributes.Add("onclick",
                                        "javascript:popupWindowDatePicker('" + txtStartDate.ClientID + "');" +
                                        "return false;"
                                        );

            // Called by "Add benefit" button            
            if (Request.QueryString["category"] == "1")
            {
                lnkOwner.HRef = "#";
                lnkOwner.Attributes.Add("onclick",
                                        "javascript:popupWindowSelectItem(1,'" +
                                        txtComments.ClientID + "','" +
                                        hOwnerID.ClientID + "');" +
                                        "return false;"
                                        );
                lnkOwner.Visible = true;
                txtComments.Attributes.Add("onfocus", "parent.focus();");
            }
            else
            {
                txtComments.Attributes["onfocus"] = "";
                lnkOwner.Visible = false;
            }


            m_dsPeriod = Global_DB.GetPeriods(m_nInitiativeID);

            LoadControls();

            if (!Page.IsPostBack)
            {
                switch ( Request.QueryString["category"] )
                {
                    case "1":
                        ddlCategory.Items.Clear();
                        ddlCategory.Items.Add( new ListItem( "Benefit", "1" ) );
                        break;

                    case "2":
                        ddlCategory.Items.Clear();
                        ddlCategory.Items.Add( new ListItem( "GTO One Time Cost", "2" ) );
                        ddlCategory.Items.Add( new ListItem( "Business Direct One Time Cost", "3" ) );
                        ddlCategory.Items.Add( new ListItem( "GTO Incremental Cost", "4" ) );
                        ddlCategory.Items.Add( new ListItem( "Business Direct Incremental Cost", "5" ) );
                        break;

                    case "9":
                    case "16":
                    case "17":
                        ddlCategory.Items.Clear();
                        ddlCategory.Items.Add(new ListItem("GTO RTB Existing", "16"));
                        ddlCategory.Items.Add(new ListItem("Business Direct RTB Existing", "17"));

                        ddlType.Items.Clear();
                        ddlType.Items.Add(new ListItem("RTB", "RTB"));
                        break;
                }

                // Rev 1.7.1, GMcF: CategoryID 9, legacy RTB Existing, is converted by default to GTO RTB Existing
                string strCategory = Request.QueryString["category"];
                ddlCategory.SelectedValue = strCategory == "9" ? "16" : strCategory;
                // End of Rev 1.7.1

                UpdateControls();
                btnCancel.Attributes.Add("onClick", "javascript:window.close()");

                //if (Request.QueryString["category"] != "9")
                {
                    GenerateJScripts();
                    FillDropDowns();
                }

                //GenerateJScripts();
                //FillDropDowns();

                if (m_nInitiativeID > 0 && 
                    Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
                {
                    Page.Title = "Update Financial Record";
                    btnOK.Text = "Update";
                    LoadInitiativeFinancial();
                }
            }
        }

        protected void LoadInitiativeFinancial()
        {
            int intInitiativeFinancialID = Convert.ToInt32(Request.QueryString["record"]);

            DataSet dsInitiativeValues = SectionC_DB.GetInitiativeValues(m_nInitiativeID);

            DataRow drFinancialRecord = SectionC_DB.GetInitiativeFinancialDetails(
                                            m_nInitiativeID, intInitiativeFinancialID);

            switch ((Int32)drFinancialRecord["CategoryID"])
            {
                case 1:
                    txtType.Text = drFinancialRecord["Type"].ToString();
                    ddlDescription.SelectedValue = drFinancialRecord["DescriptionID"].ToString();
                    break;

                case 2:
                case 3:
                case 4:
                case 5:
                    ddlType.SelectedValue = drFinancialRecord["TypeID"].ToString();
                    ddlDescription.SelectedValue = drFinancialRecord["DescriptionID"].ToString();
                    break;

                case 6:
                case 7:
                case 8:
                    ddlType.SelectedValue = drFinancialRecord["TypeID"].ToString();
                    ddlDescription.SelectedValue = drFinancialRecord["DescriptionID"].ToString();
                    break;

                case 9:
                case 16:
                case 17:
                    ddlType.SelectedValue = drFinancialRecord["TypeID"].ToString();
                    ddlDescription.SelectedValue = drFinancialRecord["DescriptionID"].ToString();

                    break;
            }

            txtComments.Text = drFinancialRecord["Comments"].ToString();
            hOwnerID.Value = drFinancialRecord["OwnerID"].ToString();

            txtBusinessGTLevel7.Text = drFinancialRecord["BusinessGTLevel7Name"].ToString();
            txtBusinessGTLevel8.Text = drFinancialRecord["BusinessGTLevel8Name"].ToString();
            txtBusinessGTLevel9.Text = drFinancialRecord["BusinessGTLevel9Name"].ToString();
            ddlBusinessGTLevel10.SelectedValue = drFinancialRecord["UBR_ID"].ToString();
            txtCustomGrouping.Text = drFinancialRecord["CustomGrouping"].ToString();    // Rev 2007-10-16, GMcF

            txtStartDate.Text = (drFinancialRecord["StartDate"] != DBNull.Value) ? ((DateTime)drFinancialRecord["StartDate"]).ToShortDateString() : "";

            
            foreach (RepeaterItem rptItem in rptControls.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                object objValue;

                //if ((bool)drPeriod["HasQuarters"])
                if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                        DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                                          "ReferenceID = " + intInitiativeFinancialID.ToString() + " AND " +
                                          "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                          "QuarterNo=" + quarterIndex.ToString());

                        if (drValues.Length > 0) objValue = drValues[0]["Amount"]; else objValue = DBNull.Value;

                        txtValue.Text = (objValue == DBNull.Value) ? "0.000000" : ((Decimal)objValue).ToString("N6");
                    }
                }
                else
                {
                    TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));
                

                    DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                                             "ReferenceID = " + intInitiativeFinancialID.ToString() + " AND " +
                                             "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                             "QuarterNo IS NULL");

                    if (drValues.Length > 0) objValue = drValues[0]["Amount"]; else objValue = DBNull.Value;

                    txtValue.Text = (objValue == DBNull.Value) ? "0.000000" : ((Decimal)objValue).ToString("N6");
                }
            }

            return;
        }

        protected void FillDropDowns()
        {
            DataSet dsUBRLookup = Global_DB.GetUBRLookupTable( Convert.ToInt32( ddlCategory.SelectedValue ) );

            ddlBusinessGTLevel10.DataSource = dsUBRLookup.Tables["UBRLookup"];
            ddlBusinessGTLevel10.DataValueField = "UBR_ID";
            ddlBusinessGTLevel10.DataTextField = "Level10";

            ddlBusinessGTLevel10.DataBind();

            ddlBusinessGTLevel10.Items[0].Text = "Please Select";
            ddlBusinessGTLevel10.Attributes.Add("onChange", "javascript:selectBusinessGT()");

            ddlType.DataValueField = "ReferenceID";
            ddlType.DataTextField = "Description";

            ddlDescription.DataValueField = "ReferenceID";
            ddlDescription.DataTextField = "Description";

            DataSet dsDescription = null, dsType = null;            

            switch (ddlCategory.SelectedValue)
            {
                case "1":
                    dsDescription = Global_DB.GetReferenceTable(9);
                    
                    dsDescription.Tables["Reference"].Columns.Add("OriginalRowID", typeof(int));
                    dsDescription.Tables["Reference"].Columns.Add("IsDefault", typeof(bool));

                    for (int i = 0; i < dsDescription.Tables["Reference"].Rows.Count;i++ )
                    {
                        dsDescription.Tables["Reference"].Rows[i]["OriginalRowID"] = i;
                        dsDescription.Tables["Reference"].Rows[i]["IsDefault"] = ((i == 0) ? true : false);
                    }

                    dsType = Global_DB.GetReferenceTable(10);
                    break;

                case "2":
                    dsDescription = Global_DB.GetReferenceTable(12);
                    dsType = Global_DB.GetReferenceTable(11);
                    break;

                case "3":
                    dsDescription = Global_DB.GetReferenceTable(13);
                    dsType = Global_DB.GetReferenceTable(11);
                    break;

                case "4":
                    dsDescription = Global_DB.GetReferenceTable(32);
                    dsType = Global_DB.GetReferenceTable(14);
                    break;

                case "5":
                    dsDescription = Global_DB.GetReferenceTable(15);
                    dsType = Global_DB.GetReferenceTable(14);
                    break;

                case "6":
                    dsDescription = Global_DB.GetReferenceTable(17);
                    dsType = Global_DB.GetReferenceTable(16);
                    break;

                case "7":
                    dsDescription = Global_DB.GetReferenceTable(19);
                    dsType = Global_DB.GetReferenceTable(16);
                    break;

                case "8":
                    dsDescription = Global_DB.GetReferenceTable(18);
                    dsType = Global_DB.GetReferenceTable(16);
                    break;

                case "9":
                    dsDescription = Global_DB.GetReferenceTable(12);
                    dsType = Global_DB.GetReferenceTable(54);
                    break;

                case "16":
                    dsDescription = Global_DB.GetReferenceTable(12);
                    dsType = Global_DB.GetReferenceTable(54);
                    break;

                case "17":
                    dsDescription = Global_DB.GetReferenceTable(13);
                    dsType = Global_DB.GetReferenceTable(54);
                    break;
            }

            if (ddlCategory.SelectedValue == "1")
            {
                DataView dvDescription = new DataView(dsDescription.Tables["Reference"]);
                dvDescription.Sort = "IsDefault DESC, Description ASC";

                ddlDescription.DataSource = dvDescription;
                ddlDescription.DataBind();

                DataTable dtType = new DataTable();
                dtType.Columns.Add("ReferenceID",typeof(int));
                dtType.Columns.Add("Description", typeof(string));

                for ( int j=0; j < dvDescription.Count; j++ )
                {
                    DataRow rowType = dtType.NewRow();
                    rowType["Description"] = dsType.Tables["Reference"].Rows[Convert.ToInt32(dvDescription[j]["OriginalRowID"])]["Description"].ToString();
                    rowType["ReferenceID"] = Convert.ToInt32(dsType.Tables["Reference"].Rows[Convert.ToInt32(dvDescription[j]["OriginalRowID"])]["ReferenceID"]);

                    dtType.Rows.Add(rowType);
                }

                ddlType.DataSource = dtType;
                ddlType.DataBind();
            }
            else
            {
                ddlDescription.DataSource = dsDescription.Tables["Reference"];
                ddlDescription.DataBind();

                ddlType.DataSource = dsType.Tables["Reference"];
                ddlType.DataBind();

                // Rev 1.7.1 GMcF
                switch (ddlCategory.SelectedItem.Value)
                {
                    case "9":
                    case "16":
                    case "17":
                        ddlType.Items.Remove(ddlType.Items[0]);     // "Please select"
                        break;
                    default:
                        break;
                }
                // End of Rev 1.7.1
            }
        }

        protected void UpdateControls()
        {
            switch (ddlCategory.SelectedValue)
            {
                case "1":
                    ddlType.Visible = true;
                    ddlType.Attributes.Add("style", "visibility:hidden;");
                    ddlType.Width = 0;

                    txtType.Visible = true;
                    lblTypeTitle.Text = "Benefits Type";
                    lblDescriptionTitle.Text = "Benefits Description";
                    lblCommentTitle.Text = "Benefit Realisation Owner";

                    lblAmountsTitle.Text = "BENEFITS";

                    lnkOwner.HRef="#";
                    lnkOwner.Attributes.Add("onclick", 
                                            "javascript:popupWindowSelectItem(1,'" +
                                            txtComments.ClientID + "','" +
                                            hOwnerID.ClientID + "');" +
                                            "return false;"
                                            );

                    lnkOwner.Visible = true;
                    txtComments.Attributes.Add("onfocus", "parent.focus();");

                    rqvComments.Enabled = true;
                    
                    break;

                case "2":
                case "3":
                case "4":
                case "5":
                    ddlType.Visible = true;
                    ddlType.Attributes.Remove("style");
                    ddlType.Width = new Unit("223px");

                    txtType.Visible = false;
                    lblTypeTitle.Text = "Spend Category";
                    lblDescriptionTitle.Text = "Spend Description";
                    lblCommentTitle.Text = "Detail As Necessary";

                    lblAmountsTitle.Text = "SPEND";

                    txtComments.Attributes["onfocus"] = "";
                    lnkOwner.Visible = false;

                    rqvComments.Enabled = false;

                    break;

                case "6":
                case "7":
                case "8":
                    ddlType.Visible = true;
                    ddlType.Attributes.Remove("style");
                    ddlType.Width = new Unit("223px");

                    txtType.Visible = false;
                    lblTypeTitle.Text = "Capex Owner";
                    lblDescriptionTitle.Text = "Spend Description";
                    lblCommentTitle.Text = "Name";

                    lblAmountsTitle.Text = "SPEND";

                    txtComments.Attributes["onfocus"] = "";
                    lnkOwner.Visible = false;

                    rqvComments.Enabled = false;

                    break;

                case "9":
                case "16":                                  // Rev 1.7.1, GMcF
                case "17":                                  // Rev 1.7.1, GMcF
                    ddlType.Visible = true;
                    ddlType.Attributes.Remove("style");
                    ddlType.Width = new Unit("223px");
                    rvType.Enabled = false;                 // Rev 1.7.1, GMcF

                    txtType.Visible = false;
                    lblTypeTitle.Text = "Spend Category";
                    lblDescriptionTitle.Text = "Spend Description";
                    lblCommentTitle.Text = "Detail As Necessary";

                    lblAmountsTitle.Text = "SPEND";

                    txtComments.Attributes["onfocus"] = "";
                    lnkOwner.Visible = false;

                    rqvComments.Enabled = false;

                    break;
            }
        }

        protected void GenerateJScripts()
        {
            DataSet dsUBRLookup = Global_DB.GetUBRLookupTable(Convert.ToInt32(ddlCategory.SelectedValue));

            ddlBusinessGTLevel7.DataSource = dsUBRLookup.Tables["UBRLookup"];
            ddlBusinessGTLevel7.DataValueField = "UBR_ID";
            ddlBusinessGTLevel7.DataTextField = "Level7Name";

            ddlBusinessGTLevel7.DataBind();


            ddlBusinessGTLevel8.DataSource = dsUBRLookup.Tables["UBRLookup"];
            ddlBusinessGTLevel8.DataValueField = "UBR_ID";
            ddlBusinessGTLevel8.DataTextField = "Level8Name";

            ddlBusinessGTLevel8.DataBind();

            ddlBusinessGTLevel9.DataSource = dsUBRLookup.Tables["UBRLookup"];
            ddlBusinessGTLevel9.DataValueField = "UBR_ID";
            ddlBusinessGTLevel9.DataTextField = "Level9Name";

            ddlBusinessGTLevel9.DataBind();

            // Rev 2007-10-16, GMcF
            ddlCustomGrouping.DataSource = dsUBRLookup.Tables["UBRLookup"];
            ddlCustomGrouping.DataValueField = "UBR_ID";
            ddlCustomGrouping.DataTextField = "CustomGrouping";

            ddlCustomGrouping.DataBind();
            // End of Rev 2007-10-16
            
            ddlBusinessGTLevel7.Attributes.Add("style", "visibility:hidden;");
            ddlBusinessGTLevel8.Attributes.Add("style", "visibility:hidden;");
            ddlBusinessGTLevel9.Attributes.Add("style", "visibility:hidden;");
            ddlCustomGrouping.Attributes.Add("style", "visibility:hidden;");  // Rev 2007-10-16, GMcF


            Page.RegisterStartupScript("selectBusinessGT",
                         "<script language=\"javascript\"> " +
                             "function selectBusinessGT() {" +
                             "document.getElementById(\"" + txtBusinessGTLevel7.ClientID + "\").value=" +
                             "document.getElementById(\"" + ddlBusinessGTLevel7.ClientID + "\").options[" +
                             "document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex" +
                             "].text; " +
                             "document.getElementById(\"" + txtBusinessGTLevel8.ClientID + "\").value=" +
                             "document.getElementById(\"" + ddlBusinessGTLevel8.ClientID + "\").options[" +
                             "document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex" +
                             "].text; " +
                             "document.getElementById(\"" + txtBusinessGTLevel9.ClientID + "\").value=" +
                             "document.getElementById(\"" + ddlBusinessGTLevel9.ClientID + "\").options[" +
                             "document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex" +
                             "].text; " +
                             // Rev 20071016, GMcF
                             "document.getElementById(\"" + txtCustomGrouping.ClientID + "\").value=" +
                             "document.getElementById(\"" + ddlCustomGrouping.ClientID + "\").options[" +
                             "document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex" +
                             "].text; " +
                            // End of Rev 20071016
                             "}" +
//                             "].text;  alert('Selected Idx = ' + document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex); }" +
                         "</script>");

            Page.RegisterStartupScript("validateDescription",
                         "<script language=\"javascript\"> " + 
                              "function validateDescription(source, arguments) {" + 
                              "if (document.getElementById(\"" + ddlDescription.ClientID + "\").selectedIndex > 0)" + 
                              "arguments.IsValid=true; " + 
                              "else " + 
                              "arguments.IsValid=false; " + 
                              "} " +
                         "</script>");

            Page.RegisterStartupScript("validateUBR",
                         "<script language=\"javascript\"> " +
                              "function validateUBR(source, arguments) {" +
                              "if (document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex > 0)" +
                              "arguments.IsValid=true; " +
                              "else " +
                              "arguments.IsValid=false; " +
                              "} " +
                         "</script>");

            if (ddlCategory.SelectedValue == "1")
            {
                Page.RegisterStartupScript("selectBenefitsDescription",
                         "<script language=\"javascript\"> " +
                             "function selectBenefitsDescription() {" +
                                 "document.getElementById(\"" + txtType.ClientID + "\").value=" +
                                 "document.getElementById(\"" + ddlType.ClientID + "\").options[" +
                                 "document.getElementById(\"" + ddlDescription.ClientID + "\").selectedIndex" +
                                 "].text; " +
                                 "document.getElementById(\"" + ddlType.ClientID + "\").selectedIndex=" +
                                 "document.getElementById(\"" + ddlDescription.ClientID + "\").selectedIndex;" +
                             "}" +
                             "selectBenefitsDescription(); " + 
                         "</script>");

                ddlDescription.Attributes.Add("onChange", "javascript:selectBenefitsDescription()");

                Page.RegisterStartupScript("validateType",
                             "<script language=\"javascript\"> " +
                                  "function validateType(source, arguments) {" +
                                      "if (document.getElementById(\"" + ddlDescription.ClientID + "\").selectedIndex > 0)" +
                                      "arguments.IsValid=true; " +
                                      "else " +
                                      "arguments.IsValid=false; " +
                                  "} " +
                             "</script>");
            }
            else
            {
                ddlDescription.Attributes.Remove("onChange");

                Page.RegisterStartupScript("validateType",
                             "<script language=\"javascript\"> " +
                                  "function validateType(source, arguments) {" +
                                      "if (document.getElementById(\"" + ddlType.ClientID + "\").selectedIndex > 0)" +
                                      "arguments.IsValid=true; " +
                                      "else " +
                                      "arguments.IsValid=false; " +
                                    "} " +
                             "</script>");
            }
        }
        
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateControls();

            // Rev 1.7.1, GMcF: condition removed
            //if (Request.QueryString["category"] != "9")
            //    {
                    GenerateJScripts();
                    FillDropDowns(); 
            //    }

        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            int intInitiativeFinancialID;

            if (m_nInitiativeID <= 0)
            {
                return;
            }

            DataRow drUBRDetails = Global_DB.GetUBRDetails(Int32.Parse(ddlBusinessGTLevel10.SelectedValue));

            if (Request.QueryString["record"] == null || Request.QueryString["record"] == String.Empty)
            {
                intInitiativeFinancialID = SectionC_DB.InsertInitiativeFinancial(
                                m_nInitiativeID,
                                ddlCategory.SelectedItem.Text,
                                Int32.Parse(ddlCategory.SelectedValue),
                                (ddlCategory.SelectedValue == "1") ? ddlType.SelectedItem.Text : ddlType.SelectedItem.Text, 
                                (ddlCategory.SelectedValue == "1") ? Int32.Parse(ddlDescription.SelectedValue) : Int32.Parse(ddlType.SelectedValue),
                                ddlDescription.SelectedItem.Text,
                                Int32.Parse(ddlDescription.SelectedValue),
                                txtComments.Text,
                                hOwnerID.Value != String.Empty ? Int32.Parse(hOwnerID.Value) : 0,
                                drUBRDetails == null ? "" : drUBRDetails["Level5Name"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level5Code"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level6Name"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level6Code"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level7Name"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level7Code"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level8Name"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level8Code"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level9Name"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level9Code"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level10Name"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["Level10Code"].ToString(),
                                drUBRDetails == null ? "" : drUBRDetails["CustomGrouping"].ToString(),
                                Int32.Parse(ddlBusinessGTLevel10.SelectedValue),
                                txtStartDate.Text != String.Empty ? (object)DateTime.Parse(txtStartDate.Text) : DBNull.Value);

                if (intInitiativeFinancialID > 0)
                {
                    foreach (RepeaterItem rptItem in rptControls.Items)
                    {
                        HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                        DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                        //if ((bool)drPeriod["HasQuarters"])
                        if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                        {
                            for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                            {
                                TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                                SectionC_DB.InsertInitiativeValue(intInitiativeFinancialID,
                                                                m_nInitiativeID,
                                                                2,
                                                                (int)drPeriod["PeriodID"],
                                                                quarterIndex,
                                                                (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                            }
                        }
                        else
                        {
                            TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));

                            SectionC_DB.InsertInitiativeValue(intInitiativeFinancialID,
                                                            m_nInitiativeID,
                                                            2,
                                                            (int)drPeriod["PeriodID"],
                                                            DBNull.Value,
                                                            (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                        }
                    }
                }
            }
            else
            {
                intInitiativeFinancialID = Convert.ToInt32(Request.QueryString["record"]);

                SectionC_DB.UpdateInitiativeFinancial(
                                                intInitiativeFinancialID,
                                                m_nInitiativeID,
                                                ddlCategory.SelectedItem.Text, 
                                                Int32.Parse(ddlCategory.SelectedValue),
                                                (ddlCategory.SelectedValue == "1") ? ddlType.SelectedItem.Text : ddlType.SelectedItem.Text,
                                                (ddlCategory.SelectedValue == "1") ? Int32.Parse(ddlDescription.SelectedValue) : Int32.Parse(ddlType.SelectedValue),
                                                ddlDescription.SelectedItem.Text,
                                                Int32.Parse(ddlDescription.SelectedValue),
                                                txtComments.Text,
                                                hOwnerID.Value != String.Empty ? Int32.Parse(hOwnerID.Value) : 0,
                                                drUBRDetails == null ? "" : drUBRDetails["Level5Name"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level5Code"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level6Name"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level6Code"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level7Name"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level7Code"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level8Name"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level8Code"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level9Name"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level9Code"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level10Name"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["Level10Code"].ToString(),
                                                drUBRDetails == null ? "" : drUBRDetails["CustomGrouping"].ToString(),
                                                Int32.Parse(ddlBusinessGTLevel10.SelectedValue),
                                                txtStartDate.Text != String.Empty ? (object)DateTime.Parse(txtStartDate.Text) : DBNull.Value);

                foreach (RepeaterItem rptItem in rptControls.Items)
                {
                    HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                    DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                    //if ((bool)drPeriod["HasQuarters"])
                    if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                            SectionC_DB.UpdateInitiativeValue(intInitiativeFinancialID,
                                                            m_nInitiativeID,
                                                            2,
                                                            (int)drPeriod["PeriodID"],
                                                            quarterIndex,
                                                            (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                        }
                    }
                    else
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));

                        SectionC_DB.UpdateInitiativeValue(intInitiativeFinancialID,
                                                        m_nInitiativeID,
                                                        2,
                                                        (int)drPeriod["PeriodID"],
                                                        DBNull.Value,
                                                        (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                    }
                }
            }

            SectionC_DB.UpdateInitiative_AllRisks(m_nInitiativeID);

            RegisterStartupScript("closeScript",
                    "<script language=JavaScript> window.returnValue=1; window.close(); </script>");
        }

        protected void LoadControls()
        {
            rptControls.DataSource = m_dsPeriod.Tables["Period"];
            rptControls.DataBind();
        }

        protected void rptControls_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trContent");

                if ((bool)DataBinder.Eval(e.Item.DataItem, "HasQuarters"))
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        HtmlTableCell td = new HtmlTableCell();
                        td.Attributes.Add("class", "summarylabel");
                        td.Attributes.Add("width", "60px");
                        td.Attributes.Add("align", "right");
                        td.InnerText = "Q" + quarterIndex.ToString() + " " + DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                        tr.Cells.Add(td);

                        td = new HtmlTableCell();

                        TextBox txtValue = new TextBox();
                        txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString() + " " + quarterIndex.ToString()).Replace(' ', '_');
                        txtValue.CssClass = "textinput";
                        txtValue.MaxLength = 50;
                        txtValue.Width = new Unit("50px");
                        txtValue.Attributes.Add("style", "text-align: center");

                        RangeValidator rvAmount = new RangeValidator();
                        rvAmount.Type = ValidationDataType.Double;
                        rvAmount.MinimumValue = "0";
                        rvAmount.MaximumValue = "1000000";
                        rvAmount.Text = "*";
                        rvAmount.ControlToValidate = txtValue.ID;

                        td.Controls.Add(txtValue);
                        td.Controls.Add(rvAmount);

                        tr.Cells.Add(td);
                    }

                    HtmlTableCell tdHidden = new HtmlTableCell();
                    HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                    hiddenPeriodID.ID = "hiddenPeriodID";
                    hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                    tdHidden.Controls.Add(hiddenPeriodID);
                    tr.Cells.Add(tdHidden);
                }
                else
                {
                    HtmlTableCell td = new HtmlTableCell();
                    td.Attributes.Add("class", "summarylabel");
                    td.Attributes.Add("width", "55px");
                    td.Attributes.Add("align", "right");
                    td.InnerText = DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                    tr.Cells.Add(td);

                    td = new HtmlTableCell();

                    TextBox txtValue = new TextBox();
                    txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString()).Replace(' ', '_');
                    txtValue.CssClass = "textinput";
                    txtValue.MaxLength = 50;
                    txtValue.Width = new Unit("50px");
                    txtValue.Attributes.Add("style", "text-align: center");

                    RangeValidator rvAmount = new RangeValidator();
                    rvAmount.Type = ValidationDataType.Double;
                    rvAmount.MinimumValue = "0";
                    rvAmount.MaximumValue = "1000000";
                    rvAmount.Text = "*";
                    rvAmount.ControlToValidate = txtValue.ID;

                    td.Controls.Add(txtValue);
                    td.Controls.Add(rvAmount);

                    tr.Cells.Add(td);

                    td = new HtmlTableCell();
                    HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                    hiddenPeriodID.ID = "hiddenPeriodID";
                    hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                    td.Controls.Add(hiddenPeriodID);
                    tr.Cells.Add(td);
                }

            }
        }
    }
}
