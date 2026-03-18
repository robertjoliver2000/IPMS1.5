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

	/// <summary>
	///		Summary description for SectionG.
	/// </summary>
	public partial class SectionG : System.Web.UI.UserControl
	{
        protected DataSet dsValue;
        protected DataSet dsPeriod;

        protected int nInitiativeID;

        protected System.Web.UI.WebControls.DropDownList Dropdownlist6;
        
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

            btnAddImpact.Attributes.Add("onclick", "javascript:popupWindowImpact(" + nInitiativeID.ToString() + ", 0)");

            lnkCIOArchApDate.HRef = "#";
            lnkCIOArchApDate.Attributes.Add("onclick",
                                            "javascript:popupWindowDatePicker('" + txtCIOArchApDate.ClientID + "');"+
                                            "return false;"
                                            );

            GenerateJScript();

            if (!Page.IsPostBack)
            {
                BindDropdowns();
                LoadInitiative();
            }

            LoadDataSets();
            BindRepeater();


            hRefCIOArchApproverID.HRef ="#";
            hRefCIOArchApproverID.Attributes.Add("onclick",
                                                "javascript:popupWindowSelectItem(1,'" +
                                                txtCIOArchApprover.ClientID + "','" +
                                                hiddenCIOArchApprover.ClientID + "');" +
                                                "return false;"
                                                );

            txtCIOArchApprover.Attributes.Add("onfocus", "parent.focus();");
                      
		}

        protected void BindDropdowns()
        {
            DataSet dsYesNo = Global_DB.GetReferenceTable(7); //CategoryID = 20 for Yes,NO

            if (dsYesNo.Tables["Reference"].Rows.Count > 0)
            {
                //-----------
                ddlUsesAproved3rdParty.DataValueField = "ReferenceID";
                ddlUsesAproved3rdParty.DataTextField = "Description";

                ddlUsesAproved3rdParty.DataSource = dsYesNo.Tables["Reference"];
                ddlUsesAproved3rdParty.DataBind();

                //-----------
                ddlTechnicalArchCompliant.DataValueField = "ReferenceID";
                ddlTechnicalArchCompliant.DataTextField = "Description";

                ddlTechnicalArchCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlTechnicalArchCompliant.DataBind();

                //-----------
                ddlBusinessArchInfo.DataValueField = "ReferenceID";
                ddlBusinessArchInfo.DataTextField = "Description";

                ddlBusinessArchInfo.DataSource = dsYesNo.Tables["Reference"];
                ddlBusinessArchInfo.DataBind();

                //-----------
                ddlApplicationArchCompliant.DataValueField = "ReferenceID";
                ddlApplicationArchCompliant.DataTextField = "Description";

                ddlApplicationArchCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlApplicationArchCompliant.DataBind();

                //-----------
                ddlApplicationArchCompliant.DataValueField = "ReferenceID";
                ddlApplicationArchCompliant.DataTextField = "Description";

                ddlApplicationArchCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlApplicationArchCompliant.DataBind();

                //-----------
                ddlTechnicalArchSatisfied.DataValueField = "ReferenceID";
                ddlTechnicalArchSatisfied.DataTextField = "Description";

                ddlTechnicalArchSatisfied.DataSource = dsYesNo.Tables["Reference"];
                ddlTechnicalArchSatisfied.DataBind();

                //-----------
                ddlDevelopmentArchCompl.DataValueField = "ReferenceID";
                ddlDevelopmentArchCompl.DataTextField = "Description";

                ddlDevelopmentArchCompl.DataSource = dsYesNo.Tables["Reference"];
                ddlDevelopmentArchCompl.DataBind();

                ddlUsesAproved3rdParty.Attributes.Add("onChange", "javascript:setApproved()");
                ddlTechnicalArchCompliant.Attributes.Add("onChange", "javascript:setApproved()");
                ddlBusinessArchInfo.Attributes.Add("onChange", "javascript:setApproved()");
                ddlApplicationArchCompliant.Attributes.Add("onChange", "javascript:setApproved()");
                ddlTechnicalArchSatisfied.Attributes.Add("onChange", "javascript:setApproved()");
                ddlDevelopmentArchCompl.Attributes.Add("onChange", "javascript:setApproved()");
            }



        }

        protected void BindRepeater()
        {
            repeaterImpact.DataSource = SectionG_DB.GetImpacts(nInitiativeID);
            repeaterImpact.DataBind();
        }

        protected void LoadDataSets() 
        {
            //dsPeriod = Global_DB.GetPeriods(nInitiativeID);
            dsPeriod = Global_DB.GetPeriodsForDisplay(nInitiativeID);

            int nTypeID = 1; //Impact

            dsValue = SectionG_DB.GetImpactValues(nInitiativeID, nTypeID);
        }


        private void LoadInitiative()
        {
            
            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                txtCIOArchApprover.Text = drInitiative["CIOArchitectureApprover"].ToString();
                hiddenCIOArchApprover.Value=drInitiative["CIOArchitectureApproverID"].ToString();

                txtCIOArchApDate.Text = (drInitiative["CIOArchitectureApprovalDate"] != DBNull.Value) ? 
                    ((DateTime)drInitiative["CIOArchitectureApprovalDate"]).ToShortDateString() : "";

                ddlUsesAproved3rdParty.SelectedValue = drInitiative["UsesApproved3rdPartySoftwareID"].ToString();
                ddlTechnicalArchCompliant.SelectedValue = drInitiative["TechnicalArchitectureCompliantID"].ToString();
                ddlBusinessArchInfo.SelectedValue = drInitiative["BusinessArchitectureInfoProvidedID"].ToString();
                ddlApplicationArchCompliant.SelectedValue = drInitiative["ApplicationArchitetureCompliantID"].ToString();
                ddlTechnicalArchSatisfied.SelectedValue = drInitiative["TechnicalArchitectureSatisfiedID"].ToString();
                ddlDevelopmentArchCompl.SelectedValue = drInitiative["DevelopmentArchitectureCompliantID"].ToString();
                
                txtJustificationForDeviation.Text= drInitiative["GTOJustification4Deviation"].ToString();
                
            }
        }

        protected void GenerateJScript()
        {
            //numectrl.options(numectrl.selectedindex).text
            //document.getElementById(\"" + lblErr.ClientID + "\").style.display=\"inline\";
            //1 means YES 3 means N/A
            Page.RegisterStartupScript("setApproved",
                            "<script language=\"javascript\"> " +
                            "function setApproved() {" +
                            "if ((document.getElementById(\"" + ddlUsesAproved3rdParty.ClientID + "\").value==\"1\" ||" +
                            "document.getElementById(\"" + ddlUsesAproved3rdParty.ClientID + "\").value==\"3\") && " +
                            "(document.getElementById(\"" + ddlTechnicalArchCompliant.ClientID + "\").value==\"1\" ||" +
                            "document.getElementById(\"" + ddlTechnicalArchCompliant.ClientID + "\").value==\"3\") && " +
                            "(document.getElementById(\"" + ddlBusinessArchInfo.ClientID + "\").value==\"1\" ||" +
                            "document.getElementById(\"" + ddlBusinessArchInfo.ClientID + "\").value==\"3\") && " +
                            "(document.getElementById(\"" + ddlApplicationArchCompliant.ClientID + "\").value==\"1\" ||" +
                            "document.getElementById(\"" + ddlApplicationArchCompliant.ClientID + "\").value==\"3\") && " +
                            "(document.getElementById(\"" + ddlTechnicalArchSatisfied.ClientID + "\").value==\"1\" ||" +
                            "document.getElementById(\"" + ddlTechnicalArchSatisfied.ClientID + "\").value==\"3\") && " +
                            "(document.getElementById(\"" + ddlDevelopmentArchCompl.ClientID + "\").value==\"1\" ||" +
                            "document.getElementById(\"" + ddlDevelopmentArchCompl.ClientID + "\").value==\"3\")) " +
                            "{document.getElementById(\"" + txtApprovedByCorporate.ClientID + "\").value=\"Yes\"; " +
                            " } " +
                            "else " +
                            "{document.getElementById(\"" + txtApprovedByCorporate.ClientID + "\").value=\"No\"; "+
                            "} " +
                            "}" +
                        "</script>");

            Page.RegisterStartupScript("setApprovedPageLoad",
                             "<script language=\"javascript\"> " +
                             "setApproved()" +
                             "</script>");
            
        }


        public int UpdateInitiative()
        {
            int nReturnValue = -1;
            int nCIOArchApproverID = 0;

            try
            {
                nCIOArchApproverID = Convert.ToInt32(hiddenCIOArchApprover.Value);
            }
            catch
            {
                nCIOArchApproverID = -1;
            }

            if (nInitiativeID > 0)
            {

                nReturnValue = SectionG_DB.UpdateInitiative_CIOConformity(nInitiativeID,
                                               nCIOArchApproverID,
                                               txtCIOArchApprover.Text,
                                               txtCIOArchApDate.Text != String.Empty ? (object)DateTime.Parse(txtCIOArchApDate.Text) : DBNull.Value, 
                                               Convert.ToInt32(ddlUsesAproved3rdParty.SelectedValue),
                                               ddlUsesAproved3rdParty.SelectedItem.Text,
                                               Convert.ToInt32(ddlTechnicalArchCompliant.SelectedValue),
                                               ddlTechnicalArchCompliant.SelectedItem.Text,
                                               Convert.ToInt32(ddlBusinessArchInfo.SelectedValue),
                                               ddlBusinessArchInfo.SelectedItem.Text,
                                               Convert.ToInt32(ddlApplicationArchCompliant.SelectedValue),
                                               ddlApplicationArchCompliant.SelectedItem.Text,
                                               Convert.ToInt32(ddlTechnicalArchSatisfied.SelectedValue),
                                               ddlTechnicalArchSatisfied.SelectedItem.Text,
                                               Convert.ToInt32(ddlDevelopmentArchCompl.SelectedValue),
                                               ddlDevelopmentArchCompl.SelectedItem.Text,
                                               txtJustificationForDeviation.Text);


                GenerateJScript();
            }

            BindRepeater();

            return nReturnValue;
        }


        protected void repeaterImpact_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            HtmlTableRow row;
            Decimal dcAmountTotal;
            string strCondition;

            //headers
            if (e.Item.ItemType == ListItemType.Header)
            {
                
                    
                row = (HtmlTableRow)e.Item.FindControl("HeaderID");
                if (row != null)
                {
                  
                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {
                        HtmlTableCell headerCell = new HtmlTableCell();
                        headerCell.Attributes.Add("width", "55");
                        headerCell.Attributes.Add("class", "headcell");
                        headerCell.Attributes.Add("align", "center");

                        headerCell.InnerHtml = dsPeriod.Tables["Period"].Rows[index - 1]["Name"].ToString();
                        row.Cells.Add(headerCell);
                    }


                    HtmlTableCell headerCellTotal = new HtmlTableCell();
                    headerCellTotal.Attributes.Add("width", "60");
                    headerCellTotal.Attributes.Add("class", "headcell");
                    headerCellTotal.Attributes.Add("align", "center");
                    headerCellTotal.InnerHtml = "Total";
                    row.Cells.Add(headerCellTotal);

                    HtmlTableCell headerCellRemediation = new HtmlTableCell();
                    headerCellRemediation.Attributes.Add("width", "125");
                    headerCellRemediation.Attributes.Add("class", "headcell");
                    headerCellRemediation.Attributes.Add("align", "left");
                    headerCellRemediation.InnerHtml = "Remediation";
                    row.Cells.Add(headerCellRemediation);
                }


            }
            //..headers


            //items
            else if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                int nImpactID=Convert.ToInt32(DataBinder.Eval(e.Item.DataItem,"InitiativeImpactID"));

                ImageButton imgButt= (ImageButton)e.Item.FindControl("delImpactID");
                if(imgButt!=null)
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this impact ?')) AllowOneTimeSubmit(); else return false; ");

                
                row = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableRow)e.Item.FindControl("RowID") : (HtmlTableRow)e.Item.FindControl("AlternateRowID");
                string strClass = (e.Item.ItemType == ListItemType.Item) ? "incell" : "alternateincell";

                if (row != null)
                {
                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {
                        
                        strCondition= "ReferenceID=" + nImpactID.ToString() + " AND PeriodID=" + dsPeriod.Tables["Period"].Rows[index - 1]["PeriodID"].ToString();
                        HtmlTableCell itemCell = new HtmlTableCell();
                        itemCell.Attributes.Add("align", "center");
                        itemCell.Attributes.Add("class", strClass);

                        DataRow[] dRows;
                        dRows = dsValue.Tables["ImpactValue"].Select(strCondition);
                        
                        Decimal dcAmount;
                        try
                        {
                            object objAmount = dRows[0]["Amount"];
                            dcAmount=Convert.ToDecimal(objAmount);
                        }
                        catch(Exception e1)
                        {
                            dcAmount=0;
                        }

                        itemCell.InnerHtml = dcAmount.ToString("N2");
                        row.Cells.Add(itemCell);

                    }

                    strCondition = "ReferenceID=" + nImpactID.ToString();

                    HtmlTableCell itemCellTotal = new HtmlTableCell();
                    itemCellTotal.Attributes.Add("align", "center");
                    itemCellTotal.Attributes.Add("class",strClass );
                    
                    try
                    {
                        dcAmountTotal = Convert.ToDecimal(dsValue.Tables["ImpactValue"].Compute("SUM(Amount)", strCondition));
                    }
                    catch (Exception e1)
                    {
                        dcAmountTotal = 0;
                    }
                    itemCellTotal.InnerHtml = dcAmountTotal.ToString("N2");
                    row.Cells.Add(itemCellTotal);

                    HtmlTableCell itemCellRemediation = new HtmlTableCell();
                    itemCellRemediation.Attributes.Add("align", "left");
                    itemCellRemediation.Attributes.Add("class", strClass);
                    itemCellRemediation.InnerHtml = DataBinder.Eval(e.Item.DataItem, "Remediation").ToString();
                    row.Cells.Add(itemCellRemediation);
                
                }

            }
            //..items

            //footers
            if (e.Item.ItemType == ListItemType.Footer)
            {
                
                row = (HtmlTableRow)e.Item.FindControl("FooterID1");
                if (row != null)
                {

                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {
                        strCondition = "PeriodID=" + dsPeriod.Tables["Period"].Rows[index - 1]["PeriodID"].ToString();

                        HtmlTableCell FooterCell = new HtmlTableCell();
                        FooterCell.Attributes.Add("class", "totalcell");
                        FooterCell.Attributes.Add("align", "center");

                        try
                        {
                            dcAmountTotal = Convert.ToDecimal(dsValue.Tables["ImpactValue"].Compute("SUM(Amount)", strCondition));
                        }
                        catch (Exception e1)
                        {
                            dcAmountTotal = 0;
                        }

                        FooterCell.InnerHtml = dcAmountTotal.ToString("N2");
                        row.Cells.Add(FooterCell);
                    }
                }

                HtmlTableCell tdEmpty = new HtmlTableCell();
                tdEmpty.Attributes.Add("class", "totalcell");

                row.Cells.Add(tdEmpty);

                tdEmpty = new HtmlTableCell();
                tdEmpty.Attributes.Add("class", "emptytotal");
                tdEmpty.Attributes.Add("style", "border-top: 1px solid;");

                row.Cells.Add(tdEmpty);

               
                row = (HtmlTableRow)e.Item.FindControl("FooterID2");
                if (row != null)
                {
                    HtmlTableCell footerCellTotal = new HtmlTableCell();
                    footerCellTotal.Attributes.Add("class", "totalcell");
                    footerCellTotal.Attributes.Add("align", "center");

                    try
                    {
                        dcAmountTotal = Convert.ToDecimal(dsValue.Tables["ImpactValue"].Compute("SUM(Amount)", ""));
                    }
                    catch (Exception e1)
                    {
                        dcAmountTotal = 0;
                    }

                    footerCellTotal.InnerHtml = dcAmountTotal.ToString("N2");
                    row.Cells.Add(footerCellTotal);
                }
                


            }
            //..footer


        }
        
        protected void repeaterImpact_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nImpactID;
            
            int nTypeID = 1; //typeID=1 for impact
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        nImpactID=Convert.ToInt32(e.CommandArgument);
                    }
                    catch(Exception e1)
                    {
                        nImpactID=-1;
                    }

                    SectionG_DB.DeleteInitiativeImpact(nInitiativeID,nImpactID,nTypeID);
                }
            }

            LoadDataSets();
            BindRepeater();
        }
}
}
