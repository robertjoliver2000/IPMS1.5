namespace ProjectPortfolio.Controls
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using ProjectPortfolio.Classes;


    public partial class SectionH_PrintVersion : System.Web.UI.UserControl
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
        }


        protected void BindRepeater()
        {
            repeaterITPolicy.DataSource = SectionH_DB.GetITPolicies(nInitiativeID);
            repeaterITPolicy.DataBind();
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
                    if (strControlID.Length >= 3)
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
                        if (strControlID.Substring(0, 3) == "ddl") //dropdowns
                        {
                            Label textSelect = new Label();
                            textSelect.ID  = strControlID;
                            //textSelect.Attributes.Add("class", "textselect");
                            textSelect.Attributes.Add("style", "width:160px;");

                            dsValue = Global_DB.GetReferenceTable(nCategoryID);
                            strValue = System.Web.UI.DataBinder.Eval(e.Item.DataItem, "ITPolicyValue").ToString();

                            /*
                            foreach (DataRow row in dsValue.Tables["Reference"].Rows)
                            {
                                
                                ListItem listItem = new ListItem();
                                listItem.Value = row["ReferenceID"].ToString();
                                listItem.Text = row["Description"].ToString();

                                if (strValue == row["Description"].ToString())
                                {
                                    listItem.Selected = true;
                                }
                                

                                
                            }
                            */

                            textSelect.Text  = strValue;

                            cell.Controls.Add(textSelect);
                        }
                        else
                        {
                            Label textInput = new Label();
                            textInput.ID = strControlID;
                            //textInput.Attributes.Add("class", "textinputgreen");
                            //textInput.Attributes.Add("readonly", "readonly");
                            textInput.Attributes.Add("style", "width:160px;");
                            textInput.Text = System.Web.UI.DataBinder.Eval(e.Item.DataItem, "ITPolicyValue").ToString().ToUpper();

                            cell.Controls.Add(textInput);
                        }
                    }
                }
            }
        }

    }
}
