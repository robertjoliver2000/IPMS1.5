/*
 *  Rev         By          Date            Description
 * 
 *  1.8.1       GMcF        2007-10-01      Amended for Secondary Functional Domain now depending on (Primary) Functional Domain
 * 
 *  2.1.3       GMcF        2008-05-01      Changed control for Phase 2.1, Deliverable 3 - SBU capture
 * 
 *  2.1.7       GMcF        2008-05-19      Amended for Phase 2.1, Deliverable 7 - Performance Status capture
 * 
 *  OTA 582     GMcF        2008-05-30      Changed for OTA 582 / Phase 2.1 Item 13 - PPR Comment handling
 * 
 */

namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
    using System.Web.UI;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using ProjectPortfolio.Classes;

	public partial class SectionA : System.Web.UI.UserControl
	{
        protected int nInitiativeID;

		protected void Page_Load(object sender, System.EventArgs e)
		{
            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }


            lnkBusinessSponsorName.HRef = "#";
            lnkBusinessSponsorName.Attributes.Add("onclick",
                                            "javascript:popupWindowSelectItem(1,'" +
                                                        txtBusinessSponsorName.ClientID + "','" +
                                                        hBusinessSponsorID.ClientID + "'); " +
                                                        "return false;"
                                                        );
            
            
            txtBusinessSponsorName.Attributes.Add("onfocus", "parent.focus();");


            lnkBusinessInitiativeManager.HRef = "#";
            lnkBusinessInitiativeManager.Attributes.Add("onclick",
                                                        "javascript:popupWindowSelectItem(1,'" +
                                                        txtBusinessInitiativeManager.ClientID + "','" +
                                                        hBusinessInitiativeManagerID.ClientID + "'); "+
                                                        "return false;"
                                                        );
            
            txtBusinessInitiativeManager.Attributes.Add("onfocus", "parent.focus();");

            lnkGTOInitiativeManager.HRef = "#";
            lnkGTOInitiativeManager.Attributes.Add("onclick",
                                                        "javascript:popupWindowSelectItem(1,'" +
                                                        txtGTOInitiativeManager.ClientID + "','" +
                                                        hGTOInitiativeManagerID.ClientID + "'); "+
                                                        "return false;"
                                                        );
 
            txtGTOInitiativeManager.Attributes.Add("onfocus", "parent.focus();");


            lnkMajorApplicationName.HRef = "#";
            lnkMajorApplicationName.Attributes.Add("onclick",
                                                        "javascript:popupWindowSelectApplication(" +
                                                        "'-1','" +
                                                        txtMajorApplicationName.ClientID + "','" +
                                                        hMajorApplicationExternalID.ClientID  +"','" +
                                                        hMajorApplicationID.ClientID + "','" +
                                                        lblMajorApplicationInvestmentStrategy.ClientID + "','" +
                                                        hMajorApplicationInvestmentStrategy.ClientID + "'); " +
                                                        "return false;"
                                                        );

            txtMajorApplicationName.Attributes.Add("onfocus", "parent.focus();");

			if (!Page.IsPostBack)
			{
				FillDropDowns();

				LoadInitiative();
			}

		}

		private void FillDropDowns()
		{
            txtInvestmentTier.Text = "";

            //ERW 6 Oct 2008 - changed to a Global enum.
            //Change future examples of this to same global Enum!
            // Rev 2.1.3, GMcF
            //DataSet dsPrimarySBUs = Global_DB.GetReferenceTable(59);
            DataSet dsPrimarySBUs = Global_DB.GetReferenceTable(Convert.ToInt32(Global.ReferenceCategoryID.PrimarySponsoringArea));
                         

            ddlPrimarySBU.DataSource = dsPrimarySBUs.Tables["Reference"];
            ddlPrimarySBU.DataValueField = "ReferenceId";
            ddlPrimarySBU.DataTextField = "Description";

            ddlPrimarySBU.DataBind();


            // Removed for Rev 1.8.1 GMcF
            //DataSet dsFunctionalDomain = Global_DB.GetReferenceTable(2);

            //ddlFunctionalDomain.DataSource = dsFunctionalDomain.Tables["Reference"];
            //ddlFunctionalDomain.DataValueField = "ReferenceID";
            //ddlFunctionalDomain.DataTextField = "Description";
            // End of Rev 1.8.1

            //Rev 1.8.1 GMcF
            // *** removed by RJO - no uch column as CombinedID in Reference
            /* DataSet dsFunctionalDomain = Global_DB.GetReferenceTableParents(2, -1);

            ddlFunctionalDomain.DataSource = dsFunctionalDomain.Tables["Reference"];
            ddlFunctionalDomain.DataValueField = "CombinedID";
            ddlFunctionalDomain.DataTextField = "Description";*/
            // End of Rev 1.8.1 GMcF
            DataSet dsFunctionalDomain = Global_DB.GetReferenceTable(2);

            ddlFunctionalDomain.DataSource = dsFunctionalDomain.Tables["Reference"];
            ddlFunctionalDomain.DataValueField = "ReferenceID";
            ddlFunctionalDomain.DataTextField = "Description";

            ddlFunctionalDomain.DataBind();

            // Removed for Rev 1.8.1 GMcF
            //DataSet dsSecondaryFunctionalDomain = Global_DB.GetReferenceTable(2);

            //ddlSecondaryFunctionalDomain.DataSource = dsSecondaryFunctionalDomain.Tables["Reference"];
            //ddlSecondaryFunctionalDomain.DataValueField = "ReferenceID";
            //ddlSecondaryFunctionalDomain.DataTextField = "Description";

            //ddlSecondaryFunctionalDomain.DataBind();
            // End of Rev 1.8.1

            DataSet dsArchitecturalComplianceType = Global_DB.GetReferenceTable(3);

            ddlArchitecturalComplianceType.DataSource = dsArchitecturalComplianceType.Tables["Reference"];
            ddlArchitecturalComplianceType.DataValueField = "ReferenceID";
            ddlArchitecturalComplianceType.DataTextField = "Description";

            ddlArchitecturalComplianceType.DataBind();


            DataSet dsRegion = Global_DB.GetReferenceTable(52);

            ddlRegion.DataSource = dsRegion.Tables["Reference"];
            ddlRegion.DataValueField = "ReferenceID";
            ddlRegion.DataTextField = "Description";

            ddlRegion.DataBind();

            DataSet dsTechnologyFunction = Global_DB.GetReferenceTable(53);

            ddlTechnologyFunction.DataSource = dsTechnologyFunction.Tables["Reference"];
            ddlTechnologyFunction.DataValueField = "ReferenceID";
            ddlTechnologyFunction.DataTextField = "Description";

            ddlTechnologyFunction.DataBind();
        }

		private void LoadInitiative()
		{
            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

			if (drInitiative != null)
			{
                // Rev 2.1.7, GMcF
                System.Web.UI.WebControls.Image imgPPRStatus;
                HiddenField hdnPPRStatus,
                            hdnPPRStatusId;
                string  PPRStatus,
                        newSrc,
                        newAlt;
                foreach (string idPart in new string[]{ "Overall", "Cost", "Deliverables", "Time", "Risks", "Benefits" })
                {
                    hdnPPRStatus = (HiddenField)FindControl("hdnPPR_" + idPart + "Status");
                    hdnPPRStatusId = (HiddenField)FindControl("hdnPPR_" + idPart + "StatusID");

                    if ( drInitiative["PPR_" + idPart + "Status"] == DBNull.Value
                            || drInitiative["PPR_" + idPart + "Status"].ToString() == "" )
                    {
                        hdnPPRStatus.Value = "Please select";
                        hdnPPRStatusId.Value = "0";
                    }
                    else
                    {
                        hdnPPRStatus.Value = drInitiative["PPR_" + idPart + "Status"].ToString();
                        hdnPPRStatusId.Value = drInitiative["PPR_" + idPart + "StatusId"].ToString();
                    }

                    switch (hdnPPRStatusId.Value)
                    {
                        case "3": newSrc = "~/Images/PPR_red.gif"; newAlt = "R - Red"; break;
                        case "2": newSrc = "~/Images/PPR_amber.gif"; newAlt = "A - Amber"; break;
                        case "1": newSrc = "~/Images/PPR_green.gif"; newAlt = "G - Green"; break;
                        default: newSrc = "~/Images/PPR_grey.gif"; newAlt = "- - Please select"; break;

                    }

                    imgPPRStatus = (System.Web.UI.WebControls.Image)FindControl("imgPPR_" + idPart);
                    imgPPRStatus.ImageUrl = newSrc;
                    imgPPRStatus.ToolTip = newAlt;
                }
                // End of rev 2.1.7


				txtName.Text = drInitiative["Name"].ToString();
				//ddlInvestmentTier.SelectedValue = drInitiative["InvestmentTierID"].ToString();
                txtInvestmentTier.Text = drInitiative["InvestmentTier"].ToString();
                if (txtInvestmentTier.Text == "" || txtInvestmentTier.Text == "Please select")
                {
                    txtInvestmentTier.Text = "Not set";
                }

                // Added 2008-05-29, GMcF, for OTA 582 / Phase 2.1 UAT Feedback Item 13 - PPR Comments
                txtPPRComments.Text = drInitiative[ "PPR_Comments" ].ToString();

                // Rev 2.1.3, GMcF

                // txtPrimarySponsoringArea.Text = drInitiative["PrimarySponsoringArea"].ToString();

                if (drInitiative["PrimarySBUID"] == DBNull.Value)
                {
                    // PrimarySBUID not already set

                    if ( drInitiative["PrimarySponsoringArea"].ToString() == string.Empty )
                        // Use "Please Select"
                        ddlPrimarySBU.SelectedIndex = 0;
                    else
                    {
                        ListItem liPSBU = ddlPrimarySBU.Items.FindByText(drInitiative["PrimarySponsoringArea"].ToString());
                        if ( liPSBU != null )
                        {
                            // Use existing item with matching text
                            ddlPrimarySBU.SelectedValue = liPSBU.Value;
                        }
                        else
                        {
                            // Add Legacy item
                            ddlPrimarySBU.Items.Add(new ListItem("[LEGACY] " + drInitiative["PrimarySponsoringArea"].ToString(), "-1"));
                            ddlPrimarySBU.SelectedValue = "-1";
                        }
                    }

                }
                else
                    // Use existing item with matching value
                    ddlPrimarySBU.SelectedValue = drInitiative["PrimarySBUID"].ToString();

                // End of Rev 2.1.3


                txtOtherSponsoringAreas.Text = drInitiative["OtherSponsoringAreas"].ToString();
                
                txtBusinessSponsorName.Text = drInitiative["BusinessSponsorName"].ToString();
                hBusinessSponsorID.Value = drInitiative["BusinessSponsorID"].ToString();

                txtBusinessInitiativeManager.Text = drInitiative["BusinessInitiativeManager"].ToString();
                hBusinessInitiativeManagerID.Value = drInitiative["BusinessInitiativeManagerID"].ToString();

                ddlRegion.SelectedValue = drInitiative["RegionID"].ToString();

                txtGTOManagingBusinessArea.Text = drInitiative["GTOManagingBusinessArea"].ToString();

                txtGTOInitiativeManager.Text = drInitiative["GTOInitiativeManager"].ToString();
                hGTOInitiativeManagerID.Value = drInitiative["GTOInitiativeManagerID"].ToString();


                // Taken out for Rev 1.8.1 GMcF
                //ddlFunctionalDomain.SelectedValue = drInitiative["FunctionalDomainID"].ToString();
                //ddlSecondaryFunctionalDomain.SelectedValue = drInitiative["SecondaryFunctionalDomainID"].ToString();
                // End of code taken out for Rev 1.8.1


                // Rev 1.8.1
                ShowPrimaryFunctionalDomain(drInitiative["FunctionalDomainID"].ToString());

                ShowSecondaryFunctionalDomain(
                                                drInitiative["SecondaryFunctionalDomainID"].ToString(),
                                                drInitiative["FunctionalDomainID"].ToString()
                                                );
                // End of Rev 1.8.1


                ddlTechnologyFunction.SelectedValue = drInitiative["TechnologyFunctionID"].ToString();
                txtMajorApplicationName.Text = drInitiative["MajorApplicationName"].ToString();
                lblMajorApplicationInvestmentStrategy.Text = drInitiative["MajorApplicationInvestmentStrategy"].ToString();
                hMajorApplicationInvestmentStrategy.Value = drInitiative["MajorApplicationInvestmentStrategy"].ToString();
                hMajorApplicationID.Value = drInitiative["MajorApplicationID"].ToString();

                txtInitiativeBusinessDrivers.Text = drInitiative["InitiativeBusinessDrivers"].ToString();
				txtInitiativeScopeAndObjectives.Text = drInitiative["InitiativeScopeAndObjectives"].ToString();
                txtInitiativeBenefitCalculation.Text = drInitiative["InitiativeBenefitCalculation"].ToString();
                txtStrategicInitiativeInterfaces.Text = drInitiative["StrategicInitiativeInterfaces"].ToString();
                txtSmartsourcingComponent.Text = drInitiative["SmartsourcingComponent"].ToString();

                txtArchitecturalCompliance.Text = drInitiative["ArchitecturalCompliance"].ToString();
                ddlArchitecturalComplianceType.SelectedValue = drInitiative["ArchitecturalComplianceTypeID"].ToString();

                //txtIGApprovalDate.Text = (drInitiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGApprovalDate"]).ToShortDateString() : String.Empty;

			}
		}

		public int InsertInitiative()
		{
            String[]    strFunctionalDomain = ddlFunctionalDomain.SelectedValue.Split('|');
            int         intFunctionalDomainID = Convert.ToInt32(strFunctionalDomain[0]);
            String[]    strSecondaryFunctionalDomain = ddlSecondaryFunctionalDomain.SelectedValue.Split('|');
            int         intSecondaryFunctionalDomainID = Convert.ToInt32(strSecondaryFunctionalDomain[0]);

			return SectionA_DB.InsertInitiative(
					txtName.Text, // initiative name
                    "GM", "0101", 1, 

                    // Rev 2.1.3, GMcF
                    // txtPrimarySponsoringArea.Text, 
                    ddlPrimarySBU.SelectedItem.Text, 
                    // end of Rev 2.1.3

                    txtOtherSponsoringAreas.Text,
                    txtBusinessSponsorName.Text,
                    hBusinessSponsorID.Value != String.Empty ? Int32.Parse(hBusinessSponsorID.Value) : 0, 
                    txtBusinessInitiativeManager.Text, 
                    hBusinessInitiativeManagerID.Value != String.Empty ? Int32.Parse(hBusinessInitiativeManagerID.Value) : 0,
                    ddlRegion.SelectedItem.Text, Convert.ToInt32(ddlRegion.SelectedValue),
                    txtGTOManagingBusinessArea.Text,
                    txtGTOInitiativeManager.Text, 
                    hGTOInitiativeManagerID.Value != String.Empty ? Int32.Parse(hGTOInitiativeManagerID.Value) : 0,
                    ddlFunctionalDomain.SelectedItem.Text, intFunctionalDomainID,
                    ddlSecondaryFunctionalDomain.SelectedItem.Text, intSecondaryFunctionalDomainID,
                    ddlTechnologyFunction.SelectedItem.Text, Convert.ToInt32(ddlTechnologyFunction.SelectedValue),
                    txtMajorApplicationName.Text, hMajorApplicationInvestmentStrategy.Value,
                    hMajorApplicationID.Value != String.Empty ? Int32.Parse(hMajorApplicationID.Value) : 0, 
					txtInitiativeBusinessDrivers.Text, 
					txtInitiativeScopeAndObjectives.Text,
                    txtInitiativeBenefitCalculation.Text,
                    txtStrategicInitiativeInterfaces.Text,
                    txtSmartsourcingComponent.Text,
                    txtArchitecturalCompliance.Text,
                    ddlArchitecturalComplianceType.SelectedItem.Text, Convert.ToInt32(ddlArchitecturalComplianceType.SelectedValue));
		}

		public int UpdateInitiative()
		{
			int intReturnValue = -1;
			
			if (nInitiativeID > 0)
			{
                // Rev 1.8.1a GMcF
                //try
                //{
                //    bool IsForReview = (bool)Parent.GetType().InvokeMember(
                //                                "IsForReview",
                //                                System.Reflection.BindingFlags.GetProperty,
                //                                null, Parent, null);
                //    if (IsForReview)
                //    {
                //        if (ddlSecondaryFunctionalDomain.SelectedIndex == 0)
                //        {
                //            ddlSecondaryFunctionalDomain.SelectedValue = ddlFunctionalDomain.SelectedValue;
                //        }
                //    }
                //}
                //catch (System.Exception e)
                //{
                //    // no action required
                //}
                // Rev 1.8.1a

                String[] strPrimaryFunctionalDomain = ddlFunctionalDomain.SelectedValue.Split('|');
                int intPrimaryFunctionalDomainID = Convert.ToInt32(strPrimaryFunctionalDomain[0]);

                String[] strSecondaryFunctionalDomain = ddlSecondaryFunctionalDomain.SelectedValue.Split('|');
                int intSecondaryFunctionalDomainID = Convert.ToInt32(strSecondaryFunctionalDomain[0]);

                intReturnValue = SectionA_DB.UpdateInitiative(
                                        nInitiativeID,
                                        txtName.Text, // initiative name

                                        // Rev 2.1.3, GMcF
                                        //txtPrimarySponsoringArea.Text,
                                        ddlPrimarySBU.SelectedItem.Text.StartsWith("[LEGACY] ") ? ddlPrimarySBU.SelectedItem.Text.Substring(9) : ddlPrimarySBU.SelectedItem.Text,
                                        Convert.ToInt32(ddlPrimarySBU.SelectedValue),
                                        // End of Rev 2.1.3

                                        txtOtherSponsoringAreas.Text,
                                        txtBusinessSponsorName.Text,
                                        hBusinessSponsorID.Value != String.Empty ? Int32.Parse(hBusinessSponsorID.Value) : 0,
                                        txtBusinessInitiativeManager.Text,
                                        hBusinessInitiativeManagerID.Value != String.Empty ? Int32.Parse(hBusinessInitiativeManagerID.Value) : 0,
                                        ddlRegion.SelectedItem.Text, Convert.ToInt32(ddlRegion.SelectedValue),
                                        txtGTOManagingBusinessArea.Text,
                                        txtGTOInitiativeManager.Text,
                                        hGTOInitiativeManagerID.Value != String.Empty ? Int32.Parse(hGTOInitiativeManagerID.Value) : 0,

                                        // Rev 1.8.1 GMcF
                                        //ddlFunctionalDomain.SelectedItem.Text, Convert.ToInt32(ddlFunctionalDomain.SelectedValue),
                                        //ddlSecondaryFunctionalDomain.SelectedItem.Text, intSecondaryFunctionalDomain.SelectedValue),
                                        ddlFunctionalDomain.SelectedItem.Text, intPrimaryFunctionalDomainID,
                                        ddlSecondaryFunctionalDomain.SelectedItem.Text, intSecondaryFunctionalDomainID,
                                        // End of Rev 1.8.1

                                        ddlTechnologyFunction.SelectedItem.Text, Convert.ToInt32(ddlTechnologyFunction.SelectedValue),
                                        txtMajorApplicationName.Text, hMajorApplicationInvestmentStrategy.Value,
                                        hMajorApplicationID.Value != String.Empty ? Int32.Parse(hMajorApplicationID.Value) : 0,
                                        txtInitiativeBusinessDrivers.Text,
                                        txtInitiativeScopeAndObjectives.Text,
                                        txtInitiativeBenefitCalculation.Text,
                                        txtStrategicInitiativeInterfaces.Text,
                                        txtSmartsourcingComponent.Text,
                                        txtArchitecturalCompliance.Text,
                                        ddlArchitecturalComplianceType.SelectedItem.Text, Convert.ToInt32(ddlArchitecturalComplianceType.SelectedValue)
                                        
                                        // Rev 2.1.7, GMcF
                                        ,
                                        hdnPPR_OverallStatus.Value, Int32.Parse(hdnPPR_OverallStatusID.Value),
                                        hdnPPR_CostStatus.Value, Int32.Parse(hdnPPR_CostStatusID.Value),
                                        hdnPPR_DeliverablesStatus.Value, Int32.Parse(hdnPPR_DeliverablesStatusID.Value),
                                        hdnPPR_TimeStatus.Value, Int32.Parse(hdnPPR_TimeStatusID.Value),
                                        hdnPPR_RisksStatus.Value, Int32.Parse(hdnPPR_RisksStatusID.Value),
                                        hdnPPR_BenefitsStatus.Value, Int32.Parse(hdnPPR_BenefitsStatusID.Value)
                                        // End of Rev 2.1.7

                                        // Added 2008-05-29, GMcF, for OTA 582 / Phase 2.1 UAT Feedback Item 13 - PPR Comments missing functionality
                                        ,
                                        txtPPRComments.Text
                                        );
			}

			return intReturnValue;
		}

        // Rev 1.8.1 GMcF
        protected void ShowPrimaryFunctionalDomain(string ReferenceID)
        {
            // Rev 1.8.1f GMcF - use GetReferenceTableParents instead of GetParentReferenceTable
            DataSet dsPrimaryFunctionalDomain = Global_DB.GetReferenceTableParents(2, ReferenceID == "" ? 0 : Convert.ToInt32(ReferenceID));

            ddlFunctionalDomain.DataSource = dsPrimaryFunctionalDomain.Tables["Reference"];
            /* *** RJO ddlFunctionalDomain.DataValueField = "CombinedID"; */
            ddlFunctionalDomain.DataValueField = "ReferenceID";
            ddlFunctionalDomain.DataTextField = "Description";

            ddlFunctionalDomain.DataBind();

            string strKey = ReferenceID.ToString() + "|" + ReferenceID.ToString();

            /* *** RJO if (System.Convert.ToInt32(dsPrimaryFunctionalDomain.Tables["Reference"].Compute("count(ReferenceId)", "CombinedId = '" + strKey + "'")) == 0)
            {
                strKey = ReferenceID.ToString() + "|0";
                if (System.Convert.ToInt32(dsPrimaryFunctionalDomain.Tables["Reference"].Compute("count(ReferenceId)", "CombinedId = '" + strKey + "'")) == 0)
                {
                    strKey = "0|0";
                }
            }*/
            ddlFunctionalDomain.SelectedValue = strKey;
        }
        // End of Rev 1.8.1


        // Rev 1.8.1 GMcF
        protected void ShowSecondaryFunctionalDomain(string ReferenceID, string ParentReferenceID)
        {
            // Rev 1.8.1f GMcF - use GetReferenceTableChildren and intParentReferenceId instead of GetParentReferenceTable
            int intParentReferenceId = -1;
            if ((ParentReferenceID == "0") || (ParentReferenceID == ""))
            {
                intParentReferenceId = -1;
            }
            else
            {
                intParentReferenceId = Convert.ToInt32(ParentReferenceID);
            }

            DataSet dsSecondaryFunctionalDomain = Global_DB.GetReferenceTableChildren(
                                                                2,
                                                                intParentReferenceId,
                                                                ReferenceID == "" ? 0 : Convert.ToInt32(ReferenceID));

            ddlSecondaryFunctionalDomain.DataSource = dsSecondaryFunctionalDomain.Tables["Reference"];
            ddlSecondaryFunctionalDomain.DataValueField = "ReferenceID";
            /* *** RJO ddlSecondaryFunctionalDomain.DataValueField = "CombinedID";*/
            ddlSecondaryFunctionalDomain.DataTextField = "Description";

            ddlSecondaryFunctionalDomain.DataBind();

            string strKey = ReferenceID.ToString() + "|" + ParentReferenceID.ToString();

            /*if (System.Convert.ToInt32(dsSecondaryFunctionalDomain.Tables["Reference"].Compute("count(ReferenceId)", "CombinedId = '" + strKey + "'")) == 0)
            {
                strKey = ReferenceID.ToString() + "|0";
                if (System.Convert.ToInt32(dsSecondaryFunctionalDomain.Tables["Reference"].Compute("count(ReferenceId)", "CombinedId = '" + strKey + "'")) == 0)
                {
                    strKey = "0|0";
                }
            }*/
            ddlSecondaryFunctionalDomain.SelectedValue = strKey;
        }
        // End of Rev 1.8.1

        // Rev 1.8.1 GMcF
        protected void ddlFunctionalDomain_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] strPrimaryDomainIdBreakdown = ((System.Web.UI.WebControls.DropDownList)sender).SelectedValue.Split('|');
            string strParentReferenceId = strPrimaryDomainIdBreakdown[1];
            ShowSecondaryFunctionalDomain("0", strParentReferenceId);
        }
        // End of Rev 1.8.1

        // Rev 1.8.1 GMcF
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            if (ddlFunctionalDomain.Visible)
            {
                String csName = ddlFunctionalDomain.ClientID + "_onclick";
                Type csType = this.GetType();

                ClientScriptManager cs = Page.ClientScript;

                if (!cs.IsStartupScriptRegistered(csType, csName))
                {
                    String csScript = "<script language=\"javascript\">" +

                                            "Events_chainEvent(" +
                                            "document.getElementById(\"" + ddlFunctionalDomain.ClientID + "\"), " +
                                            "\"onchange\", \"AllowOneTimeSubmit();\");\n" +
                                            "\n" +

                                            "function validateSecondaryFunctionalDomain( sender, clientsideargs )\n" +
                                            "{\n" +
                                            "   clientsideargs.IsValid = false;\n" +
                                            "   if (clientsideargs.Value == '0|0')\n" +
                                            "   {\n" +
                                            "       clientsideargs.IsValid = true;\n" +
                                            "   }\n" +
                                            "   else\n" +
                                            "   {\n"  +
                                            "       var strSFD = clientsideargs.Value.split('|');\n" +
                                            "\n" +
                                            "       if (strSFD[ 1 ] != '0')\n" +
                                            "       {\n" +
                                            "           var ddlPFD = document.getElementById(\"" + ddlFunctionalDomain.ClientID + "\");\n" +
                                            "           var strPFD = ddlPFD.value.split('|');\n" +
                                            "           clientsideargs.IsValid = true;\n" +
                                            "       }\n" +
                                            "   }\n" +
                                            "\n" +
                                            "}\n" +

                                            "function validateFunctionalDomain( sender, clientsideargs )\n" +
                                            "{\n" +
                                            "   clientsideargs.IsValid = false;\n" +
                                            "   if (clientsideargs.Value == '0|0')\n" +
                                            "   {\n" +
                                            "       clientsideargs.IsValid = true;\n" + // covered by required field validator
                                            "   }\n" +
                                            "   if (clientsideargs.Value != '0|0')\n" +
                                            "   {\n" +
                                            "       var strFD = clientsideargs.Value.split('|');\n" +
                                            "\n" +
                                            "       if (strFD[ 1 ] != '0')\n" +
                                            "       {\n" +
                                            "           clientsideargs.IsValid = true;\n" +
                                            "       }\n" +
                                            "   }\n" +
                                            "\n" +
                                            "}\n" +

                                            "</script>";
                    cs.RegisterStartupScript(csType, csName, csScript, false);
                }

            }
        }
        // End of Rev 1.8.1

        // Rev 1.8.1 GMcF
        protected void sectionA_cuvSecondaryFunctionalDomain_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //string[] strSFD = ddlSecondaryFunctionalDomain.SelectedValue.Split('|');
            args.IsValid = false;
            if (args.Value == "0|0")
            {
                args.IsValid = true;
            }
            else
            {
                string[] strSFD = args.Value.Split('|');

                if (strSFD[1] != "0")
                {
                    string[] strPFD = ddlFunctionalDomain.SelectedValue.Split('|');
                    if (strSFD[1] == strPFD[1])
                    {
                        args.IsValid = true;
                    }
                }
            }

        }
        // End of Rev 1.8.1

        // Rev 1.8.1a GMcF
        protected void sectionA_cuvFunctionalDomain_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;
            if (args.Value.EndsWith("|0"))
            {
                args.IsValid = false;
            }
        }
        // End of Rev 1.8.1a
    }

}
