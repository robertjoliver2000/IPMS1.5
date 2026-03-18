namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
    using ProjectPortfolio.Classes;


    public partial class SectionH : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.DropDownList Dropdownlist6;
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

            BindRepeater();
            GenerateJScript();
        }


        protected void BindRepeater()
        {
            repeaterITPolicy.DataSource = SectionH_DB.GetITPolicies(nInitiativeID);
            repeaterITPolicy.DataBind();
        }


        public int UpdateInitiative()
        {
            int nReturnValue = -1;

            if (nInitiativeID > 0)
            {
                DataSet ds = SectionH_DB.GetITPoliciesControls();

                int nITPolicy;
                foreach(DataRow row in ds.Tables["ITPolicyControl"].Rows)
                {
                    if (row["ControlID"].ToString() == "txtITPolicy")
                    {
                        HtmlInputText ctlITPolicyCompliance = GetITPolicyControl(row["ControlID"].ToString()) as HtmlInputText;

                        if (ctlITPolicyCompliance != null)
                        {
                            string strValue = ctlITPolicyCompliance.Value.ToString();

                            nITPolicy = (strValue == "YES") ? 1 : ((strValue == "NO") ? 2 : -1);

                            SectionH_DB.UpdateITPolicy(nInitiativeID, row["ControlID"].ToString(),
                                                        nITPolicy, Convert.ToInt32(row["CategoryID"]));
                        }
                    }
                    else
                    {
                        
                        HtmlSelect ctlITPolicy = GetITPolicyControl(row["ControlID"].ToString()) as HtmlSelect;

                        if (ctlITPolicy != null)
                        {
                            nITPolicy = Convert.ToInt32(ctlITPolicy.Value);
                            SectionH_DB.UpdateITPolicy(nInitiativeID, row["ControlID"].ToString(),
                                                        nITPolicy, Convert.ToInt32(row["CategoryID"]));
                        }
                    }
                }
            }

            BindRepeater();
            GenerateJScript();

            return nReturnValue;
        }


        protected void repeaterITPolicy_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataSet dsValue;
            int nCategoryID = 0;
            string strInner;
            string strControlID;
            string strValue;
          
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                HtmlTableCell firstCell = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableCell)e.Item.FindControl("FirstCellID") : (HtmlTableCell)e.Item.FindControl("FirstCellID");
                if (firstCell != null)
                {
                     strControlID = Convert.ToString(System.Web.UI.DataBinder.Eval(e.Item.DataItem, "ControlID"));
                     if(strControlID.Length>=3)
                         if (strControlID.Substring(0, 3) == "hpl") //hyperlink
                         {
                             HtmlAnchor link = new HtmlAnchor();

                             link.InnerText = "Link to Sourcing Management Unit Intranet";
                             link.HRef = "http://policies.intranet.db.com/service/corppurch/index.html";
                             link.Target = "_blank";

                             firstCell.Controls.Add(link);
                         }
                }
                   
                
                HtmlTableCell cell = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableCell)e.Item.FindControl("CellID") : (HtmlTableCell)e.Item.FindControl("AlternateCellID");

                if (cell != null)
                {
                    nCategoryID = Convert.ToInt32(System.Web.UI.DataBinder.Eval(e.Item.DataItem, "CategoryID"));
                    strControlID = Convert.ToString(System.Web.UI.DataBinder.Eval(e.Item.DataItem, "ControlID"));
                    
                    if (nCategoryID > 0)
                    {
                        if (strControlID.Substring(0,3)=="ddl") //dropdowns
                        {
                            HtmlSelect textSelect = new HtmlSelect();
                            textSelect.ID = strControlID;
                            textSelect.Attributes.Add("class", "textselect");
                            textSelect.Attributes.Add("style", "width:160px;");
                            textSelect.Attributes.Add("onchange", "javascript:setITPolicy()");

                            dsValue = Global_DB.GetReferenceTable(nCategoryID);
                            strValue = System.Web.UI.DataBinder.Eval(e.Item.DataItem, "ITPolicyValue").ToString();

                            foreach (DataRow row in dsValue.Tables["Reference"].Rows)
                            {
                                ListItem listItem = new ListItem();
                                listItem.Value = row["ReferenceID"].ToString();
                                listItem.Text = row["Description"].ToString();

                                if (strValue == row["Description"].ToString())
                                {
                                    listItem.Selected = true;
                                }                                    

                                textSelect.Items.Add(listItem);
                            }

                            cell.Controls.Add(textSelect);
                        }
                        else if (strControlID.Substring(0, 3) == "txt") //dropdowns
                        {
                            HtmlInputText textInput = new HtmlInputText();
                            textInput.ID = strControlID;
                            textInput.Attributes.Add("class", "textinputgreen");
                            textInput.Attributes.Add("readonly", "readonly");
                            textInput.Attributes.Add("style", "width:160px;");

                            cell.Controls.Add(textInput);
                        }
                        else
                        {
                            HtmlAnchor link = new HtmlAnchor();

                            link.HRef = "http://policies.intranet.db.com/service/corppurch/index.html";

                            cell.Controls.Add(link);
                        }
                    }
                }
            }
        }

        public HtmlControl GetITPolicyControl(string strID)
        {
            HtmlControl htmlControl;

            foreach (RepeaterItem item in repeaterITPolicy.Items)
            {
                htmlControl = item.FindControl(strID) as HtmlControl;

                if (htmlControl != null)
                {
                    return htmlControl;
                }
            }

            return null;
        }


        protected void GenerateJScript()
        {            
            //1 means FULL OR YES, 4 means N/App, 2 means NO 
            Page.RegisterStartupScript("setITPolicy",
                               "<script language=\"javascript\"> " +
                               "function setITPolicy() {" +
                               "if ((document.getElementById(\"" + GetITPolicyControl("ddlITPolicy89").ClientID + "\").value==\"1\" ||" +
                                   "document.getElementById(\"" + GetITPolicyControl("ddlITPolicy89").ClientID + "\").value==\"4\") && " +
                                   "(document.getElementById(\"" + GetITPolicyControl("ddlITPolicy91").ClientID + "\").value==\"1\" ||" +
                                   "document.getElementById(\"" + GetITPolicyControl("ddlITPolicy91").ClientID + "\").value==\"4\") && " +
                                   "(document.getElementById(\"" + GetITPolicyControl("ddlITPolicy93").ClientID + "\").value==\"1\" ||" +
                                   "document.getElementById(\"" + GetITPolicyControl("ddlITPolicy93").ClientID + "\").value==\"4\") && " +
                                   "(document.getElementById(\"" + GetITPolicyControl("ddlITPolicy95").ClientID + "\").value==\"1\" ||" +
                                   "document.getElementById(\"" + GetITPolicyControl("ddlITPolicy95").ClientID + "\").value==\"4\"))  " +
                                   "{"+
                                        "document.getElementById(\"" + GetITPolicyControl("txtITPolicy").ClientID + "\").value=\"YES\";" +
                                   "}"+     
                              "else {"+
                                  "if((document.getElementById(\"" + GetITPolicyControl("ddlITPolicy89").ClientID + "\").value==\"0\") && " +
                                       "(document.getElementById(\"" + GetITPolicyControl("ddlITPolicy91").ClientID + "\").value==\"0\") && " +
                                       "(document.getElementById(\"" + GetITPolicyControl("ddlITPolicy93").ClientID + "\").value==\"0\") && " +
                                       "(document.getElementById(\"" + GetITPolicyControl("ddlITPolicy95").ClientID + "\").value==\"0\"))  " +
                                       "{"+
                                            "document.getElementById(\"" + GetITPolicyControl("txtITPolicy").ClientID + "\").value=\"\";" +
                                       "}"+
                                   "else {"+
                                        "document.getElementById(\"" + GetITPolicyControl("txtITPolicy").ClientID + "\").value=\"NO\";" +
                                   "}"+
                               "}"+
                              "}"+
                           "</script>");

             Page.RegisterStartupScript("setITPolicyPageLoad",
                               "<script language=\"javascript\"> " +
                                "setITPolicy()" +
                               "</script>");
        }
    }
}
