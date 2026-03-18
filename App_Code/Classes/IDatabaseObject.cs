using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace ProjectPortfolio.Classes
{
    /// <summary>
    /// Summary description for IDatabaseObject
    /// </summary>
    public interface IDatabaseObject  
    {

        bool Update(int ID);
        bool Insert();
        DataSet Select(int ID);
        bool Delete(int ID);

   }
}