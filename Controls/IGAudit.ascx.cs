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

public partial class Controls_IGAudit : System.Web.UI.UserControl
{
    DataView dvAudit;
    int nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            nInitiativeID = -1;
            tbAuditID.Visible = true;
        } 

        lnkUserName.HRef = "#";
        lnkUserName.Attributes.Add("onclick",
                                "javascript:popupWindowSelectItem(1,'" +
                                txtUserName.ClientID + "','" +
                                hUserID.ClientID + "'); " +
                                "return false;"
                                );
        lnkUserName.Visible = false;

        lnkModifyDate.HRef = "#";
        lnkModifyDate.Attributes.Add("onclick",
                                "javascript:popupWindowDatePicker('" + txtModifyDate.ClientID + "'); " +
                                "return false;"
                                );

        //txtModifyDate.Attributes.Add("onfocus", "parent.focus();");

        
        if (!Page.IsPostBack)
        {
            if (nInitiativeID == -1) //for the case when the IGAudit control does not get any parms.
                SetEmptyView(); // just to show the headers
            else
            {
                SetInitiativeView();

            }

            FillDropDowns();

            Session["IGAudit_SortExpression"] = String.Empty;
            Session["IGAudit_SortDirection"] = String.Empty;
        }
        else
        {
            if (Session["IGAudit_SortExpression"] == null)
            {
                Session["IGAudit_SortExpression"] = String.Empty;
                Session["IGAudit_SortDirection"] = String.Empty;
            }

            if (Session["IGAudit_SortDirection"] == null)
            {
                Session["IGAudit_SortDirection"] = String.Empty;
            }

            //CheckCondition();

            //dvAudit.Sort = Session["IGAudit_SortExpression"].ToString() != String.Empty ?
            //           (Session["IGAudit_SortExpression"].ToString() + " " + Session["IGAudit_SortDirection"].ToString()) :
            //            null;
        }

        gvAudit.DataSource = dvAudit;
        gvAudit.DataBind();

    }

    protected void SetEmptyView()
    {
        DataTable dtAudit = new DataTable();
        
        DataView dv;
        DataRow row;


        dtAudit.Columns.Add(new DataColumn("TableName", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("ColumnName", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("ReferenceID", typeof(int)));
        dtAudit.Columns.Add(new DataColumn("OldValue", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("NewValue", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("Surname", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("Firstname", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("ModifiedDate", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("ModifiedBy", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("Computer", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("IGIdentifier", typeof(string)));
        dtAudit.Columns.Add(new DataColumn("InitiativeID", typeof(int)));
        dtAudit.Columns.Add(new DataColumn("Version", typeof(string)));

        row = dtAudit.NewRow();
        row["TableName"] = "[dbo].[";
        
        dtAudit.Rows.Add(row);

        dvAudit = new DataView(dtAudit);
       
    }


    protected void FillDropDowns()
    {
        //categoryID=33 - > "IGAuditTable"
        DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(33);

        ddlTableName.DataSource = dsIGApprovalCommittee.Tables["Reference"];
        ddlTableName.DataValueField = "ReferenceID";
        ddlTableName.DataTextField = "Description";

        ddlTableName.DataBind();
    }


    protected void CheckCondition()
    {
        AuditFilter auditFilter = new AuditFilter();
        
        if (nInitiativeID != -1)
        {
            auditFilter.InitiativeID = nInitiativeID;
        }
        if (ddlTableName.SelectedIndex != 0)
        {
            auditFilter.TableName = ddlTableName.SelectedItem.Text;
        }
        if (txtIGIdentifier.Text != "")
        {
            auditFilter.IGIdentifier = txtIGIdentifier.Text;
        }
        if (txtUserName.Text != "")
        {
            auditFilter.UserName = txtUserName.Text;
        }
        if (txtModifyDate.Text != "")
        {
            auditFilter.ModifyDate = Convert.ToDateTime(txtModifyDate.Text);
        }
        else
            auditFilter.ModifyDate = DateTime.MinValue;
       
        DataSet dsAudit = Audit_DB.GetAuditTable(auditFilter);

        dvAudit = new DataView(dsAudit.Tables["Audit"]);

        if (dvAudit.Count == 0) //just to show the headers
            SetEmptyView();
              
    }

    protected void SetInitiativeView()
    {
        AuditFilter auditFilter = new AuditFilter();

        if (nInitiativeID != -1)
        {
            auditFilter.InitiativeID = nInitiativeID;
        }
        
        DataSet dsAudit = Audit_DB.GetAuditTable(auditFilter);

        dvAudit = new DataView(dsAudit.Tables["Audit"]);

        if (dvAudit.Count == 0) //just to show the headers
            SetEmptyView();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvAudit.PageIndex = 0;

        CheckCondition();

        gvAudit.DataSource = dvAudit;
        gvAudit.DataBind();
        
    }

    protected void gvAudit_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (Session["IGAudit_SortExpression"].ToString() == e.SortExpression)
        {
            Session["IGAudit_SortDirection"] = (Session["IGAudit_SortDirection"].ToString() == "ASC") ? "DESC" : "ASC";
        }
        else
        {
            //Session["Coordinator_IGAudit"] = "ASC";
            Session["IGAudit_SortDirection"] = "ASC";
        }

        Session["IGAudit_SortExpression"] = e.SortExpression;

        //string stest = Session["IGAudit_SortExpression"].ToString() + " " + Session["IGAudit_SortDirection"].ToString();

        //fix for header sort
        CheckCondition();
        //end

        dvAudit.Sort = Session["IGAudit_SortExpression"].ToString() + " " + Session["IGAudit_SortDirection"].ToString();
        //dvAudit.Sort = Session["IGAudit_SortExpression"].ToString() + "ASC";
        //dvAudit.Sort = "ModifiedDate ASC";
        
        gvAudit.DataSource = dvAudit;
        gvAudit.DataBind();
    }

    protected void gvAudit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }

    protected void gvAudit_RowCommand(object sender, GridViewCommandEventArgs e)
    {      
    }

    protected void gvAudit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        CheckCondition();
        
        gvAudit.PageIndex = e.NewPageIndex;
           

        gvAudit.DataSource = dvAudit;
        gvAudit.DataBind();
                
    }

    protected string GetIGTableName(string strTable)
    {
        string strTableName = strTable.Substring(7);
        strTableName=strTableName.Replace("]","");
        
        return Audit_DB.GetIGTableName(strTableName);
    }
}
