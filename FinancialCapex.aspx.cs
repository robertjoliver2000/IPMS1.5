//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.2.1       CA          23/06/2007      Del 90
//      2007-10-17  GMcF        16/10/2007      HW Request - add column CustomGrouping to InitiativeFinancial
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
        protected DataSet m_dsPeriodForDisplay;

        //rev ca
        string sCapDepTotal;

        decimal dCapDepTotal;
        decimal dCapexTotal;
        decimal dReconDiffTotal;
        //end rev ca


        //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
        protected enum EffectiveCategory
        {
            EmptyList = -1,
            GTO = 2,
            nonGTO = 3
        }

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
            m_dsPeriodForDisplay = Global_DB.GetPeriodsForDisplay(m_nInitiativeID);

            LoadControls();

            if (!Page.IsPostBack)
            {
                ddlCategory.SelectedValue = Request.QueryString["category"];
                UpdateControls();
                btnCancel.Attributes.Add("onClick", "javascript:window.close()");

                GenerateJScripts();
                FillDropDowns();                

                if (m_nInitiativeID > 0 && 
                    Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
                {
                    Page.Title = "Update Financial Record";
                    btnOK.Text = "Update";
                    LoadInitiativeFinancial();
                }
            }

            //rev ca
            dReconDiffTotal =  dCapexTotal - dCapDepTotal;

            if (dReconDiffTotal == 0)
            {
                hiddenReconciliationDifference.Value = "0";
            }
            else
            {
            hiddenReconciliationDifference.Value = dReconDiffTotal.ToString();
            }
            //end rev ca
        }
        
        protected void LoadInitiativeFinancial()
        {
            int intInitiativeFinancialID = Convert.ToInt32(Request.QueryString["record"]);

            DataSet dsInitiativeValues = SectionC_DB.GetInitiativeValues(m_nInitiativeID);

            DataRow drFinancialRecord = SectionC_DB.GetInitiativeFinancialDetails(
                                            m_nInitiativeID, intInitiativeFinancialID);

            //rev ca
            dCapexTotal = 0;
            //end rev ca

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
                case 15: //rev 1.2.1 added Category 15 CA
                    ddlType.SelectedValue = drFinancialRecord["TypeID"].ToString();
                    ddlDescription.SelectedValue = drFinancialRecord["DescriptionID"].ToString();

                    //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
                    GenerateJScripts();
                    FillUBRs();
                    FillDepreciationSpendTypes();
                    break;
            }

            txtComments.Text = drFinancialRecord["Comments"].ToString();
            hOwnerID.Value = drFinancialRecord["OwnerID"].ToString();

            txtBusinessGTLevel7.Text = drFinancialRecord["BusinessGTLevel7Name"].ToString();
            txtBusinessGTLevel8.Text = drFinancialRecord["BusinessGTLevel8Name"].ToString();
            txtBusinessGTLevel9.Text = drFinancialRecord["BusinessGTLevel9Name"].ToString();
            ddlBusinessGTLevel10.SelectedValue = drFinancialRecord["UBR_ID"].ToString();
            txtCustomGrouping.Text = drFinancialRecord["CustomGrouping"].ToString();

            txtStartDate.Text = (drFinancialRecord["StartDate"] != DBNull.Value) ? ((DateTime)drFinancialRecord["StartDate"]).ToShortDateString() : "";

            
            foreach (RepeaterItem rptItem in rptControls.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                object objValue;

                if ((bool)drPeriod["HasQuarters"])
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                        DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                                          "ReferenceID = " + intInitiativeFinancialID.ToString() + " AND " +
                                          "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                          "QuarterNo=" + quarterIndex.ToString());

                        if (drValues.Length > 0) objValue = drValues[0]["Amount"]; else objValue = DBNull.Value;

                        txtValue.Text = (objValue == DBNull.Value) ? "0.00" : ((Decimal)objValue).ToString("N6");

                        //rev ca
                        dCapexTotal = dCapexTotal + Convert.ToDecimal(txtValue.Text);
                        //end rev ca
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

                    txtValue.Text = (objValue == DBNull.Value) ? "0.00" : ((Decimal)objValue).ToString("N6");

                    //rev ca
                    dCapexTotal = dCapexTotal + Convert.ToDecimal(txtValue.Text);
                    //end rev ca
                }
            }

            LoadCapexDepreciations(intInitiativeFinancialID);

            return;
        }

        protected void LoadCapexDepreciations(int intCapexFinancialID)
        {
            DataSet dsDepreciations = SectionC_DB.GetInitiativeCapexDepreciations(intCapexFinancialID);            

            int intDepreciationsCount = dsDepreciations.Tables["Depreciations"].Rows.Count;
           
            DataRow drDepreciation = null;

            string strScriptDepreciationsVisibility = String.Empty;

            //rev ca
            dCapDepTotal = 0;
            //end rev ca

            if (intDepreciationsCount > 0)
            {
                drDepreciation = dsDepreciations.Tables["Depreciations"].Rows[0];
                hiddenDepreciationFinancialID1.Value = drDepreciation["InitiativeFinancialID"].ToString();

                //rev ca
                sCapDepTotal = drDepreciation["DepreciationSum"].ToString();
                dCapDepTotal = Convert.ToDecimal(sCapDepTotal);
                //end rev ca

                LoadCapexDepreciationLine(dataListSpend1, ddlSpend1, intCapexFinancialID, drDepreciation);

                if ( intDepreciationsCount > 1)
                {
                    drDepreciation = dsDepreciations.Tables["Depreciations"].Rows[1];
                    hiddenDepreciationFinancialID2.Value = drDepreciation["InitiativeFinancialID"].ToString();

                    LoadCapexDepreciationLine(dataListSpend2, ddlSpend2, intCapexFinancialID, drDepreciation);

                    hiddenDepreciationStatus2.Value = "insert";

                    strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine2\"); " +
                            "line.style.visibility = \"visible\"; ";
                            
                    hiddenDepreciationSum2.Value = drDepreciation["DepreciationSum"].ToString();

                    //rev ca
                    dCapDepTotal = dCapDepTotal + Convert.ToDecimal(hiddenDepreciationSum2.Value);
                    //end rev ca
                }   
                else
                {
                    strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine2\"); " +
                            "line.style.visibility = \"hidden\"; ";                            
                }

                if (intDepreciationsCount > 2)
                {
                    drDepreciation = dsDepreciations.Tables["Depreciations"].Rows[2];
                    hiddenDepreciationFinancialID3.Value = drDepreciation["InitiativeFinancialID"].ToString();

                    LoadCapexDepreciationLine(dataListSpend3, ddlSpend3, intCapexFinancialID, drDepreciation);

                    hiddenDepreciationStatus3.Value = "insert";

                    strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine3\"); " +
                        "line.style.visibility = \"visible\"; ";
                        
                    hiddenDepreciationSum3.Value = drDepreciation["DepreciationSum"].ToString();

                    //rev ca
                    dCapDepTotal = dCapDepTotal + Convert.ToDecimal(hiddenDepreciationSum3.Value);
                    //end rev ca
                }
                else
                {
                    strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine3\"); " +
                        "line.style.visibility = \"hidden\"; ";
                }

                if (intDepreciationsCount > 3)
                {
                    drDepreciation = dsDepreciations.Tables["Depreciations"].Rows[3];
                    hiddenDepreciationFinancialID4.Value = drDepreciation["InitiativeFinancialID"].ToString();

                    LoadCapexDepreciationLine(dataListSpend4, ddlSpend4, intCapexFinancialID, drDepreciation);

                    hiddenDepreciationStatus4.Value = "insert";

                    strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine4\"); " +
                    "line.style.visibility = \"visible\"; ";

                    hiddenDepreciationSum4.Value = drDepreciation["DepreciationSum"].ToString();

                    //rev ca
                    dCapDepTotal = dCapDepTotal + Convert.ToDecimal(hiddenDepreciationSum4.Value);
                    //end rev ca
                }
                else
                {
                    strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine4\"); " +
                    "line.style.visibility = \"hidden\"; ";
                }

                Page.RegisterStartupScript("scriptDepreciationsVisibility",
                    "<script language=\"javascript\"> " + strScriptDepreciationsVisibility + "</script>");
            }
            else
            {
                return;
            }
        
  
        }

        protected void LoadCapexDepreciationLine(DataList dataListSpend, DropDownList ddlSpend, int intCapexFinancialID, DataRow drDepreciation)
        {
            DataSet dsDepreciations = SectionC_DB.GetInitiativeCapexDepreciations(intCapexFinancialID);
            DataSet dsInitiativeValues = SectionC_DB.GetInitiativeValues(m_nInitiativeID);

            int intDepreciationFinancialID = (int)drDepreciation["InitiativeFinancialID"];

            foreach (DataListItem rptItem in dataListSpend.Items)
            {                
                ddlSpend.SelectedValue = drDepreciation["CategoryID"].ToString();

                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));
                               
                if ((bool)drPeriod["HasQuarters"])
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                        DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                                          "ReferenceID = " + intDepreciationFinancialID.ToString() + " AND " +
                                          "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                          "QuarterNo=" + quarterIndex.ToString());

                        if (drValues.Length > 0)
                            txtValue.Text = drValues[0]["Amount"].ToString();
                        else
                            txtValue.Text = "0.0";
                    }
                }
                else
                {
                    TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));

                    DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                         "ReferenceID = " + intDepreciationFinancialID.ToString() + " AND " +
                         "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                         "QuarterNo IS NULL");

                    if (drValues.Length > 0)
                        txtValue.Text = drValues[0]["Amount"].ToString();
                    else
                        txtValue.Text = "0.0";
                }
            } 
        }

        protected int GetEffectiveCategory()
        {
            int effectiveCategory;

            if (ddlType.SelectedItem == null || ddlType.SelectedIndex == 0)
            {
                effectiveCategory = (int)EffectiveCategory.EmptyList;
            }
            else if (ddlType.SelectedItem.Text.IndexOf("GTO") > -1)
            {
                effectiveCategory = (int)EffectiveCategory.GTO;
            }
            else
            {
                effectiveCategory = (int)EffectiveCategory.nonGTO;
            }

            return effectiveCategory;
        }

        //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
        protected void FillUBRs()
        {
            /**/

            DataSet dsUBRLookup = Global_DB.GetUBRLookupTable(GetEffectiveCategory());
            /**/

            /*
            DataSet dsUBRLookup = Global_DB.GetUBRLookupTable();
        
            dsUBRLookup.Tables["UBRLookup"].Columns.Add("Level10", System.Type.GetType("System.String"), "Level10Code + ' - ' + Level10Name");
            */

            ddlBusinessGTLevel10.DataSource = dsUBRLookup.Tables["UBRLookup"];
            ddlBusinessGTLevel10.DataValueField = "UBR_ID";
            ddlBusinessGTLevel10.DataTextField = "Level10";

            ddlBusinessGTLevel10.DataBind();

            ddlBusinessGTLevel10.Items[0].Text = "Please Select";
            ddlBusinessGTLevel10.Attributes.Add("onChange", "javascript:selectBusinessGT()");
        }

        protected void FillDropDowns()
        {
            FillUBRs();
            FillDepreciationSpendTypes();

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
                
                //rev 1.2.1 CA
                case "15":
                    dsDescription = Global_DB.GetReferenceTable(51);
                    dsType = Global_DB.GetReferenceTable(16);
                    break;
                //end rev 1.2.1
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

                //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
                //dsType.Tables[0].Rows[0].Delete();    // Take out the 'Please Select' option

                ddlType.DataSource = dsType.Tables["Reference"];
                ddlType.DataBind();
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
                case "15": //rev 1.2.1 added Category 15 CA
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
            }
        }
        
        protected void GenerateJScripts()
        {
            DataSet dsUBRLookup = Global_DB.GetUBRLookupTable(GetEffectiveCategory());

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
            // End or Rev 2007-10-16

            ddlBusinessGTLevel7.Attributes.Add("style", "visibility:hidden;");
            ddlBusinessGTLevel8.Attributes.Add("style", "visibility:hidden;");
            ddlBusinessGTLevel9.Attributes.Add("style", "visibility:hidden;");
            ddlCustomGrouping.Attributes.Add("style", "visibility:hidden;");    // Rev 2007-10-16, GMcF
            

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
                             // Rev 2007-10-16, GMcF
                             "document.getElementById(\"" + txtCustomGrouping.ClientID + "\").value=" +
                             "document.getElementById(\"" + ddlCustomGrouping.ClientID + "\").options[" +
                             "document.getElementById(\"" + ddlBusinessGTLevel10.ClientID + "\").selectedIndex" +
                             "].text; " +
                             // End of Rev 2007-10-16
                             "}" +
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

            GenerateJScripts();
            FillDropDowns();
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

                        if ((bool)drPeriod["HasQuarters"])
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


                InsertFinancialDepreciations(intInitiativeFinancialID);
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

                    if ((bool)drPeriod["HasQuarters"])
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

                UpdateFinancialDepreciations(intInitiativeFinancialID);
            }

            SectionC_DB.UpdateInitiative_AllRisks(m_nInitiativeID);
                                    

            RegisterStartupScript("closeScript",
                    "<script language=JavaScript> window.returnValue=1; window.close(); </script>");
        }

        protected void InsertFinancialDepreciations(int intCapexFinancialID)
        {
            InsertFinancialDepreciations(ddlSpend1, dataListSpend1, intCapexFinancialID);

            if (hiddenDepreciationStatus2.Value.Equals("insert"))
                InsertFinancialDepreciations(ddlSpend2, dataListSpend2, intCapexFinancialID);

            if (hiddenDepreciationStatus3.Value.Equals("insert"))
                InsertFinancialDepreciations(ddlSpend3, dataListSpend3, intCapexFinancialID);

            if (hiddenDepreciationStatus4.Value.Equals("insert"))
                InsertFinancialDepreciations(ddlSpend4, dataListSpend4, intCapexFinancialID);
        }

        protected void InsertFinancialDepreciations(DropDownList ddlSpend, DataList dataListSpend, int intCapexFinancialID)
        {
            int intInitiativeFinancialID;

            if (m_nInitiativeID <= 0)
            {
                return;
            }

            if (!IsValidFinancialDepreciationLine(dataListSpend))
                return;


            string strType = string.Empty;

            if (ddlSpend.SelectedItem.Value == "11" || ddlSpend.SelectedItem.Value == "12")
                strType = "CTB";
            else
                strType = "RTB";

            DataRow drUBRDetails = Global_DB.GetUBRDetails(Int32.Parse(ddlBusinessGTLevel10.SelectedValue));

            intInitiativeFinancialID = SectionC_DB.InsertInitiativeFinancialDepreciation(
                m_nInitiativeID,
                "Depreciation HW/SW",
                Int32.Parse(ddlSpend.SelectedValue),
                strType,
                "Depreciation HW/SW",
                -1,
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
                txtStartDate.Text != String.Empty ? (object)DateTime.Parse(txtStartDate.Text) : DBNull.Value,
                intCapexFinancialID);

            InsertDepreciationValues(intInitiativeFinancialID, dataListSpend);
           
        }

        protected bool IsValidFinancialDepreciationLine(DataList dataListSpend)
        {
            bool result = false;

            foreach (DataListItem rptItem in dataListSpend.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                if ((bool)drPeriod["HasQuarters"])
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                        if (txtValue.Text != String.Empty)
                            result = true;
                    }
                }
                else
                {
                    TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));

                    if (txtValue.Text != String.Empty)
                        result = true;
                }
            }

            return result;
        }

        protected void InsertDepreciationValues(int intInitiativeFinancialID, DataList dataListSpend)
        {
            if (intInitiativeFinancialID > 0)
            {
                foreach (DataListItem rptItem in dataListSpend.Items)
                {
                    HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                    DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                    if ((bool)drPeriod["HasQuarters"])
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

        protected void UpdateFinancialDepreciations(int intCapexFinancialID)
        {
            int intFinancialDepreciationID;
            intFinancialDepreciationID = Convert.ToInt32(hiddenDepreciationFinancialID1.Value);

            UpdateFinancialDepreciations(intFinancialDepreciationID, ddlSpend1, dataListSpend1, intCapexFinancialID);

            if (hiddenDepreciationFinancialID2.Value != String.Empty)
            {
                intFinancialDepreciationID = Convert.ToInt32(hiddenDepreciationFinancialID2.Value);
                if (hiddenDepreciationStatus2.Value.Equals("insert"))
                {
                    // update record               
                    UpdateFinancialDepreciations(intFinancialDepreciationID, ddlSpend2, dataListSpend2, intCapexFinancialID);
                }
                else
                {
                    // delete record
                    DeleteFinancialDepreciation(m_nInitiativeID, intFinancialDepreciationID);
                }
            }
            else
            {
                // insert depreciation line
                InsertFinancialDepreciations(ddlSpend2, dataListSpend2, intCapexFinancialID);
            }

            if (hiddenDepreciationFinancialID3.Value != String.Empty)
            {
                intFinancialDepreciationID = Convert.ToInt32(hiddenDepreciationFinancialID3.Value);
                if (hiddenDepreciationStatus3.Value.Equals("insert"))
                {
                    // update record               
                    UpdateFinancialDepreciations(intFinancialDepreciationID, ddlSpend3, dataListSpend3, intCapexFinancialID);
                }
                else
                {
                    // delete record
                    DeleteFinancialDepreciation(m_nInitiativeID, intFinancialDepreciationID);
                }
            }
            else
            {
                // insert depreciation line
                InsertFinancialDepreciations(ddlSpend3, dataListSpend3, intCapexFinancialID);
            }

            if (hiddenDepreciationFinancialID4.Value != String.Empty)
            {
                intFinancialDepreciationID = Convert.ToInt32(hiddenDepreciationFinancialID4.Value);
                if (hiddenDepreciationStatus4.Value.Equals("insert"))
                {
                    // update record               
                    UpdateFinancialDepreciations(intFinancialDepreciationID, ddlSpend4, dataListSpend4, intCapexFinancialID);
                }
                else
                {
                    // delete record
                    DeleteFinancialDepreciation(m_nInitiativeID, intFinancialDepreciationID);
                }
            }
            else
            {
                // insert depreciation line
                InsertFinancialDepreciations(ddlSpend4, dataListSpend4, intCapexFinancialID);
            }            
        }

        protected void UpdateFinancialDepreciations(int intFinancialDepreciationID, DropDownList ddlSpend, DataList dataListSpend, int intCapexFinancialID)
        {
            if (m_nInitiativeID <= 0)
            {
                return;
            }

            if (!IsValidFinancialDepreciationLine(dataListSpend))
            {
                // you should not update an invalid depreciation line
                // delete the line from database
                DeleteFinancialDepreciation(m_nInitiativeID, intCapexFinancialID);
                return;
            }

            // update InitiativeFinancial table
            string strType = string.Empty;

            if (ddlSpend.SelectedItem.Value == "11" || ddlSpend.SelectedItem.Value == "12")
                strType = "CTB";
            else
                strType = "RTB";

            DataRow drUBRDetails = Global_DB.GetUBRDetails(Int32.Parse(ddlBusinessGTLevel10.SelectedValue));

            SectionC_DB.UpdateInitiativeFinancial(
                intFinancialDepreciationID, m_nInitiativeID,
                "Depreciation HW/SW",  Int32.Parse(ddlSpend.SelectedValue),
                strType, 0,
                "Depreciation HW/SW", -1,
                "",0,
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

            UpdateFinancialDepreciationValues(intFinancialDepreciationID, dataListSpend);
        }

        protected void UpdateFinancialDepreciationValues(int intFinancialDepreciation, DataList dataListSpend)
        {
            foreach (DataListItem rptItem in dataListSpend.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                //if ((bool)drPeriod["HasQuarters"])
                if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                        SectionC_DB.UpdateInitiativeValue(intFinancialDepreciation,
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

                    SectionC_DB.UpdateInitiativeValue(intFinancialDepreciation,
                                                    m_nInitiativeID,
                                                    2,
                                                    (int)drPeriod["PeriodID"],
                                                    DBNull.Value,
                                                    (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                }
            }
        }

        protected void DeleteFinancialDepreciation(int intInitiativeID, int intFinancialDepreciationID)
        {
            SectionC_DB.DeleteInitiativeFinancialDepreciation(intInitiativeID, intFinancialDepreciationID);
        }

        protected void LoadControls()
        {
            rptControls.DataSource = m_dsPeriod.Tables["Period"];
            rptControls.DataBind();           

            dataListHeaders.DataSource = m_dsPeriod.Tables["Period"];
            dataListHeaders.DataBind();

            LoadControlsDepreciations();
        }

        protected void LoadControlsDepreciations()
        {
            dataListSpend1.DataSource = m_dsPeriod.Tables["Period"];
            dataListSpend1.DataBind();

            dataListSpend2.DataSource = m_dsPeriod.Tables["Period"];
            dataListSpend2.DataBind();

            dataListSpend3.DataSource = m_dsPeriod.Tables["Period"];
            dataListSpend3.DataBind();

            dataListSpend4.DataSource = m_dsPeriod.Tables["Period"];
            dataListSpend4.DataBind(); 
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
                    txtValue.Attributes.Add("onBlur", "setValues('" + txtValue.ClientID + "',1);");
                    txtValue.Attributes.Add("onFocus", "getValues('" + txtValue.ClientID + "',1);");

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

        /*
        protected void dataListDepreciation_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlTableCell td = (HtmlTableCell)e.Item.FindControl("tdContent");
                
                if ((bool)DataBinder.Eval(e.Item.DataItem, "HasQuarters"))
                {                                     
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {                        
                        HtmlTableCell tdCell = new HtmlTableCell();
                        tdCell.Attributes.Add("class", "summarylabel");
                        tdCell.Attributes.Add("width", "70px");
                        tdCell.Attributes.Add("height", "14px");
                        tdCell.Attributes.Add("align", "left");
                        tdCell.InnerText = "Q" + quarterIndex.ToString() + " " + DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                        
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
                                             
                        tdCell.Controls.Add(txtValue);
                        tdCell.Controls.Add(rvAmount);

                        txtValue = new TextBox();
                        txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString() + " " + quarterIndex.ToString()).Replace(' ', '_') + "_1";
                        txtValue.CssClass = "textinput";
                        txtValue.MaxLength = 50;
                        txtValue.Width = new Unit("50px");
                        txtValue.Attributes.Add("style", "text-align: center");
                       

                        rvAmount = new RangeValidator();
                        rvAmount.Type = ValidationDataType.Double;
                        rvAmount.MinimumValue = "0";
                        rvAmount.MaximumValue = "1000000";
                        rvAmount.Text = "*";
                        rvAmount.ControlToValidate = txtValue.ID;

                        tdCell.Controls.Add(txtValue);
                        tdCell.Controls.Add(rvAmount);

                        td.Controls.Add(tdCell);                        
                    }                    
                
                }
                else
                {                    
                    td.Attributes.Add("class", "summarylabel");
                    td.Attributes.Add("width", "70px");
                    td.Attributes.Add("align", "left");
                    td.InnerText = DataBinder.Eval(e.Item.DataItem, "Name").ToString();                    

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

                    txtValue = new TextBox();
                    txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString()).Replace(' ', '_') + "_1";
                    txtValue.CssClass = "textinput";
                    txtValue.MaxLength = 50;
                    txtValue.Width = new Unit("50px");
                    txtValue.Attributes.Add("style", "text-align: center");

                    rvAmount = new RangeValidator();
                    rvAmount.Type = ValidationDataType.Double;
                    rvAmount.MinimumValue = "0";
                    rvAmount.MaximumValue = "1000000";
                    rvAmount.Text = "*";
                    rvAmount.ControlToValidate = txtValue.ID;

                    td.Controls.Add(txtValue);
                    td.Controls.Add(rvAmount);
                 
                }
            }
        }
        */

         protected void dataListDepreciation_ItemDataBound(object sender, DataListItemEventArgs e)
         {
             if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
             {
                HtmlTableCell tdContent = (HtmlTableCell)e.Item.FindControl("tdContent");
                HtmlTableRow trAll = new HtmlTableRow();

                if ((bool)DataBinder.Eval(e.Item.DataItem, "HasQuarters"))
                {
                    HtmlTable tableAll = new HtmlTable();            
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        HtmlTable table = new HtmlTable();
                        table.Attributes.Add("border", "0");

                        HtmlTableRow tr = new HtmlTableRow();
                        HtmlTableCell td = new HtmlTableCell();

                        td.Attributes.Add("class", "summarylabel");
                        td.Attributes.Add("width", "70px");
                        td.Attributes.Add("heigh", "14px");
                        td.Attributes.Add("align", "center");
                        td.InnerText = "Q" + quarterIndex.ToString() + " " + DataBinder.Eval(e.Item.DataItem, "Name").ToString();

                        tr.Controls.Add(td);
                        table.Rows.Add(tr);

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

                        tr = new HtmlTableRow();                        
                        td = new HtmlTableCell();
                        td.Controls.Add(txtValue);
                        td.Controls.Add(rvAmount);

                        //tr.Controls.Add(td);
                        //table.Rows.Add(tr);

                        txtValue = new TextBox();
                        txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString() + " " + quarterIndex.ToString()).Replace(' ', '_') + "_1";
                        txtValue.CssClass = "textinput";
                        txtValue.MaxLength = 50;
                        txtValue.Width = new Unit("50px");
                        txtValue.Attributes.Add("style", "text-align: center");


                        rvAmount = new RangeValidator();
                        rvAmount.Type = ValidationDataType.Double;
                        rvAmount.MinimumValue = "0";
                        rvAmount.MaximumValue = "1000000";
                        rvAmount.Text = "*";
                        rvAmount.ControlToValidate = txtValue.ID;

                        tr = new HtmlTableRow();
                        td = new HtmlTableCell();
                        td.Controls.Add(txtValue);
                        td.Controls.Add(rvAmount);

                        tr.Controls.Add(td);
                        table.Rows.Add(tr);
                                                
                        td = new HtmlTableCell();
                        td.Controls.Add(table);
                        trAll.Controls.Add(td);                        
                    }
                    tableAll.Controls.Add(trAll);
                    tdContent.Controls.Add(tableAll);
                }
                else
                {
                    HtmlTable table = new HtmlTable();                    
                    table.Attributes.Add("border", "0");                    

                    HtmlTableRow tr = new HtmlTableRow();
                    HtmlTableCell td = new HtmlTableCell();

                    td.Attributes.Add("class", "summarylabel");
                    td.Attributes.Add("width", "70px");
                    td.Attributes.Add("heigh", "14px");
                    td.Attributes.Add("align", "center");
                    td.InnerText = DataBinder.Eval(e.Item.DataItem, "Name").ToString();

                    tr.Controls.Add(td);
                    table.Rows.Add(tr);

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

                    tr = new HtmlTableRow();
                    td = new HtmlTableCell();
                    td.Controls.Add(txtValue);
                    td.Controls.Add(rvAmount);

                    //tr.Controls.Add(td);
                    //table.Rows.Add(tr);

                    txtValue = new TextBox();
                    txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString()).Replace(' ', '_') + "_1";
                    txtValue.CssClass = "textinput";
                    txtValue.MaxLength = 50;
                    txtValue.Width = new Unit("50px");
                    txtValue.Attributes.Add("style", "text-align: center");

                    rvAmount = new RangeValidator();
                    rvAmount.Type = ValidationDataType.Double;
                    rvAmount.MinimumValue = "0";
                    rvAmount.MaximumValue = "1000000";
                    rvAmount.Text = "*";
                    rvAmount.ControlToValidate = txtValue.ID;

                    tr = new HtmlTableRow();
                    td = new HtmlTableCell();
                    td.Controls.Add(txtValue);
                    td.Controls.Add(rvAmount);

                    tr.Controls.Add(td);
                    table.Rows.Add(tr);

                    tdContent.Controls.Add(table);
                }
             }
         }

        protected void dataListHeaders_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HtmlTableCell td = (HtmlTableCell)e.Item.FindControl("tdContent");

            //if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
            if (Convert.ToInt16(DataBinder.Eval(e.Item.DataItem, "HasQuarters")) ==1 )
            {
                for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                {
                    HtmlTableCell tdQuarter = new HtmlTableCell();
                    tdQuarter.Attributes.Add("class", "summarylabel");
                    tdQuarter.Attributes.Add("align", "center");
                    tdQuarter.Attributes.Add("width", "65px");                    
                    tdQuarter.InnerText = "Q" + quarterIndex.ToString() + " " + DataBinder.Eval(e.Item.DataItem, "Name").ToString();

                    td.Controls.Add(tdQuarter);
                }

                HtmlTableCell tdHidden = new HtmlTableCell();
                HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                hiddenPeriodID.ID = "hiddenPeriodID";
                hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                tdHidden.Controls.Add(hiddenPeriodID);
                td.Controls.Add(tdHidden);
            }
            else
            {
                td.Attributes.Add("class", "summarylabel");
                td.Attributes.Add("align", "center");
                string strPeriodName = DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                if (strPeriodName.Substring(0, 3).Equals("PRE"))
                {
                    td.Attributes.Add("width", "70px");                    
                }             
                else
                {
                    td.Attributes.Add("width", "60px");
                }
                td.InnerText = DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                           

                HtmlTableCell tdHidden = new HtmlTableCell();
                HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                hiddenPeriodID.ID = "hiddenPeriodID";
                hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                tdHidden.Controls.Add(hiddenPeriodID);
                td.Controls.Add(tdHidden);
            }
        }

        protected void dataListSpend_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HtmlTableCell td = (HtmlTableCell)e.Item.FindControl("tdContent");

            //if ((bool)DataBinder.Eval(e.Item.DataItem, "HasQuarters"))
            if (Convert.ToInt16(DataBinder.Eval(e.Item.DataItem, "HasQuarters")) == 1)
            {
                for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                {
                    TextBox txtValue = new TextBox();
                    txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString() + " " + quarterIndex.ToString()).Replace(' ', '_');
                    txtValue.CssClass = "textinput";
                    txtValue.Attributes.Add("style", "text-align: center;width:67px");                    

                    td.Controls.Add(txtValue);
                }                

                HtmlTableCell tdHidden = new HtmlTableCell();
                HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                hiddenPeriodID.ID = "hiddenPeriodID";
                hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                tdHidden.Controls.Add(hiddenPeriodID);
                td.Controls.Add(tdHidden);
            }
            else
            {
                string strPeriodName = DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                TextBox txtValue = new TextBox();
                txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString()).Replace(' ', '_');
                txtValue.CssClass = "textinput";

                if (strPeriodName.Substring(0, 1).Equals("P"))
                {
                    txtValue.Attributes.Add("style", "text-align: center;width:70px");                    
                }
                else
                {
                    txtValue.Attributes.Add("style", "text-align: center;width:60px");
                }

                td.Controls.Add(txtValue);

                HtmlTableCell tdHidden = new HtmlTableCell();
                HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                hiddenPeriodID.ID = "hiddenPeriodID";
                hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                tdHidden.Controls.Add(hiddenPeriodID);
                td.Controls.Add(tdHidden);
            }
        }        

        protected override void OnPreRender(EventArgs e)
        {            
            foreach (RepeaterItem rptItem in rptControls.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                if ((bool)drPeriod["HasQuarters"])
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));
                        txtValue.Attributes.Add("onBlur", "setValues('" + txtValue.ClientID + "',1,0);");
                        txtValue.Attributes.Add("onFocus", "getValues('" + txtValue.ClientID + "',1,0);");
                    }
                }
                else
                {
                    TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));
                    txtValue.Attributes.Add("onBlur", "setValues('" + txtValue.ClientID + "',1,0);");
                    txtValue.Attributes.Add("onFocus", "getValues('" + txtValue.ClientID + "',1,0);");
                }
            }
               
            setBlurFocusEvents(dataListSpend1, 1);
            setBlurFocusEvents(dataListSpend2, 2);
            setBlurFocusEvents(dataListSpend3, 3);
            setBlurFocusEvents(dataListSpend4, 4);                                     

            TextBox txtReconciliationDifference = (TextBox)Page.FindControl("txtBoxReconciliation");
            if ( txtReconciliationDifference != null )
                txtReconciliationDifference.Attributes.Add("style", "text-align: center");
            

            // when new capex-depreciation - hide depreciation lines:2-4

            if ( !Page.IsPostBack)
            {                                 
                if (Request.QueryString["record"] == null || Request.QueryString["record"] == String.Empty)
                {
                    String strScriptHiddeDepreciationLines = "<script language=\"javascript\"> " +
                        "for (i=2; i<5; i++) " +
                        "{ " +
                        "line = document.getElementById(\"trDepreciationLine\"+i); " +
                        "line.style.visibility = \"hidden\"; " +
                        "}; " +
                        "</script>";
                    Page.RegisterStartupScript("ScriptHiddeDepreciationLines", strScriptHiddeDepreciationLines);
                }
            }            
            else
            {
                DisplayValidLines();
                
            }
            base.OnPreRender(e);
        }  
      
        private void setBlurFocusEvents(DataList dlDepreciation, int intNumber)
        {
            foreach (DataListItem rptItem in dlDepreciation.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                if ((bool)drPeriod["HasQuarters"])
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));
                        txtValue.Attributes.Add("onBlur", "setValues('" + rptItem.ClientID + "_" + txtValue.ID + "',0,"+intNumber.ToString()+");");
                        txtValue.Attributes.Add("onFocus", "getValues('" + rptItem.ClientID + "_" + txtValue.ID + "',0," + intNumber.ToString() + ");");
                    }
                }
                else
                {
                    TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));
                    txtValue.Attributes.Add("onBlur", "setValues('" + rptItem.ClientID + "_" + txtValue.ID + "',0," + intNumber.ToString() + ");");
                    txtValue.Attributes.Add("onFocus", "getValues('" + rptItem.ClientID + "_" + txtValue.ID + "',0," + intNumber.ToString() + ");");
                }
            }
        }

        protected void DisplayValidLines()
        {
            // display only valid lines
            string strScriptDepreciationsVisibility = String.Empty;

            if (IsValidFinancialDepreciationLine(dataListSpend2))
            {
                strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine2\"); " +
                    "line.style.visibility = \"visible\"; ";
            }
            else
            {
                strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine2\"); " +
                    "line.style.visibility = \"hidden\"; ";
            }

            if (IsValidFinancialDepreciationLine(dataListSpend3))
            {
                strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine3\"); " +
                    "line.style.visibility = \"visible\"; ";
            }
            else
            {
                strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine3\"); " +
                    "line.style.visibility = \"hidden\"; ";
            }

            if (IsValidFinancialDepreciationLine(dataListSpend4))
            {
                strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine4\"); " +
                    "line.style.visibility = \"visible\"; ";
            }
            else
            {
                strScriptDepreciationsVisibility += "line = document.getElementById(\"trDepreciationLine4\"); " +
                    "line.style.visibility = \"hidden\"; ";
            }

            Page.RegisterStartupScript("ScriptVisibilityValidDeprecationsLines",
                "<script language=\"javascript\">" + strScriptDepreciationsVisibility + "</script>");
        }

        //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
        protected void SetDepreciationSpendOptions(DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("Please select", "0"));

            switch (GetEffectiveCategory())
            {
                case (int)EffectiveCategory.GTO:
                    ddl.Items.Add(new ListItem("GTO One Time Cost", "11"));
                    ddl.Items.Add(new ListItem("GTO Incremental Cost","13"));
                    break;

                case (int)EffectiveCategory.nonGTO:
                    ddl.Items.Add(new ListItem("Business Direct One Time Cost", "12"));
                    ddl.Items.Add(new ListItem("Business Direct Incremental Cost","14"));
                    break;

            }
        }

        //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
        protected void FillDepreciationSpendTypes()
        {
            SetDepreciationSpendOptions(ddlSpend1);
            SetDepreciationSpendOptions(ddlSpend2);
            SetDepreciationSpendOptions(ddlSpend3);
            SetDepreciationSpendOptions(ddlSpend4);
        }

        //Added 2007-11-30, GMcF, for Bug 27 - Filtered UBR code in CAPEX Financials
        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            GenerateJScripts();
            FillUBRs();
            FillDepreciationSpendTypes();
        }
}   
}
