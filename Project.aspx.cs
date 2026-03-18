//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.4       CA          13/02/2007     New Dynamic Header for Date
//                                              
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
    public partial class Project : System.Web.UI.Page

    {
        protected int nInitiativeID;

        //rev 1.1.4 CA
        string dInitiativeYear;
        //end rev

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Page.RegisterStartupScript("validateType",
                            "<script language=\"javascript\"> " +
                                 "function validateType(source, arguments) {" +
                                     "if (document.getElementById(\"" + ddlProjectType.ClientID + "\").selectedIndex > 0)" +
                                     "arguments.IsValid=true; " +
                                     "else " +
                                     "arguments.IsValid=false; " +
                                 "} " +
                            "</script>");


            
            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }

            if (!Page.IsPostBack)
            {

                DataSet dsProjecType = Global_DB.GetReferenceTable(20); //CategoryID = 20 for project types
                DataSet dsBaseCurrency = Global_DB.GetReferenceTable(21);//CategoryID = 21 for currencies

                if (dsProjecType.Tables["Reference"].Rows.Count > 0)
                {
                    ddlProjectType.DataValueField = "ReferenceID";
                    ddlProjectType.DataTextField = "Description";

                    ddlProjectType.DataSource = dsProjecType.Tables["Reference"];
                    ddlProjectType.DataBind();


                }
                
                if (dsBaseCurrency.Tables["Reference"].Rows.Count > 0)
                {
                    ddlBaseCurrency.DataValueField = "ReferenceID";
                    ddlBaseCurrency.DataTextField = "Description";

                    ddlBaseCurrency.DataSource = dsBaseCurrency.Tables["Reference"];
                    ddlBaseCurrency.DataBind();

                }
                
                object objPrjID=Request.QueryString["ProjectID"];
                if (objPrjID != null)
                {
                    //editing
                    int prjID = Int32.Parse(objPrjID.ToString());
                    DataRow dRow = SectionJ_DB.GetProject(prjID).Tables["Project"].Rows[0];

                    decimal dcPercentRequired,dcTotalPlanLC,dcAmountRequestedEUROs;

                    try
                    {
                        dcPercentRequired = Convert.ToDecimal(dRow["PercentRequired"].ToString());
                    }
                    catch (Exception e1)
                    {
                        dcPercentRequired = 0;
                    }

                    try
                    {
                        dcTotalPlanLC = Convert.ToDecimal(dRow["TotalPlanLocalCurrency"].ToString());
                    }
                    catch (Exception e1)
                    {
                        dcTotalPlanLC = 0;
                    }


                    try
                    {
                        dcAmountRequestedEUROs = Convert.ToDecimal(dRow["IGAmountRequested"].ToString());
                    }
                    catch (Exception e1)
                    {
                        dcAmountRequestedEUROs = 0;
                    }

                    txtProjectID.Text = dRow["ExternalProjectID"].ToString();
                    txtProjectName.Text = dRow["ProjectName"].ToString();
                    txtProjectDescr.Text = dRow["ProjectDescription"].ToString();
                    txtProgramName.Text = dRow["ProgramName"].ToString();
                    ddlProjectType.SelectedIndex = Convert.ToInt32(dRow["ProjectTypeID"]);
                    
                    //remove the percent required BugRef5 12Jan2006
                    //txtPercentRequired.Text = dRow["PercentRequired"].ToString();

                    txtAmountRequested.Text = dcAmountRequestedEUROs.ToString("N2");

                    txtTotalPlanLC.Text = dRow["TotalPlanLocalCurrency"].ToString();
                    ddlBaseCurrency.SelectedIndex = Convert.ToInt32(dRow["BaseCurrencyID"]);
                    txtFXRate.Text = dRow["FXRate"].ToString();
                }
                else //adding (set defaults)
                {
                    decimal dcOne = 1;
                    
                    txtFXRate.Text = dcOne.ToString("N3");
                    ddlBaseCurrency.SelectedIndex = 7;//EUR
                }
                
            }
            //rev 1.1.4
            DataRow drInitiative = SectionJ_DB.GetInitiativeDetails(nInitiativeID);

            dInitiativeYear = drInitiative["SubmissionDate"].ToString();
            dInitiativeYear = dInitiativeYear.Substring(8, 2);
            
            Label lblTotalLocal = (Label)Page.FindControl("lblTotalLocal");

            if (lblTotalLocal != null)
            {
                lblTotalLocal.Text = "Total Plan " + dInitiativeYear + " in Local Currency as per BEN 'PROVIDER VIEW'";
            }
            //end rev
        }

    
        
        protected void btnOK_Click(object sender, EventArgs e)
        {

            object objPrjID = Request.QueryString["ProjectID"];
            
            decimal dcPercentRequired,dcAmountRequestedEUROs,dcTotalPlanLC,dcFXRate;

            try
            {
                dcTotalPlanLC = Convert.ToDecimal(txtTotalPlanLC.Text);
            }
            catch (Exception e1)
            {
                dcTotalPlanLC = 0;
            }

            try
            {
                dcFXRate = Convert.ToDecimal(txtFXRate.Text);
            }
            catch (Exception e1)
            {
                dcFXRate = 0;
            }

            try
            {
                dcAmountRequestedEUROs = Convert.ToDecimal(txtAmountRequested.Text);
            }
            catch (Exception e1)
            {
                dcAmountRequestedEUROs = 0;
            }

            try
            {
                //remove the percent required BugRef5 12Jan2006
                //dcPercentRequired = Convert.ToDecimal(txtPercentRequired.Text);
                //dcAmountRequestedEUROs = Convert.ToDecimal(txtAmountRequested.Text);
                dcPercentRequired = (dcAmountRequestedEUROs / (dcTotalPlanLC * dcFXRate)) * 100;
                
            }
            catch (Exception e1)
            {
                dcPercentRequired = 0;
            }
            
            
            
            
            

            if (objPrjID == null)
            {
                SectionJ_DB.InsertInitiativeProject(nInitiativeID,
                                                    Convert.ToString(txtProjectID.Text),
                                                    Convert.ToString(txtProjectName.Text),
                                                    Convert.ToString(txtProjectDescr.Text),
                                                    Convert.ToString(txtProgramName.Text),
                                                    Convert.ToInt32(ddlProjectType.SelectedValue),
                                                    ddlProjectType.SelectedItem.Text.ToString(),
                                                    dcAmountRequestedEUROs,
                                                    dcPercentRequired,
                                                    dcTotalPlanLC,
                                                    Convert.ToInt32(ddlBaseCurrency.SelectedValue),
                                                    ddlBaseCurrency.SelectedItem.Text.ToString(),
                                                    dcFXRate);
            }
            else
            {
                int prjID = Int32.Parse(objPrjID.ToString());
                SectionJ_DB.UpdateInitiativeProject(prjID,
                                                    nInitiativeID,
                                                    Convert.ToString(txtProjectID.Text),
                                                    Convert.ToString(txtProjectName.Text),
                                                    Convert.ToString(txtProjectDescr.Text),
                                                    Convert.ToString(txtProgramName.Text),
                                                    Convert.ToInt32(ddlProjectType.SelectedValue),
                                                    ddlProjectType.SelectedItem.Text.ToString(),
                                                    dcAmountRequestedEUROs,
                                                    dcPercentRequired,
                                                    dcTotalPlanLC,
                                                    Convert.ToInt32(ddlBaseCurrency.SelectedValue),
                                                    ddlBaseCurrency.SelectedItem.Text.ToString(),
                                                    dcFXRate);
            }
                        
            RegisterStartupScript("closeScript",
                "<script language=JavaScript>  window.returnValue = 1; window.close();  </script>");
            
        }
}
}
