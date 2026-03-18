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
    /// Summary description for Class1
    /// </summary>
    /// 

    public abstract class aDatabaseObject : IDatabaseObject
    {
        protected DataAccess m_DataAccess;

        protected bool m_Dirty;

	    public bool Dirty
	    {
		    get { return m_Dirty;}
		    //set { m_Dirty = value;}
	    }
	


       public aDatabaseObject()
       {
           m_DataAccess = new DataAccess();
           m_DataAccess.Initialise("GlobalConnectionString");

           m_Dirty = false; 
       }


        public abstract bool Update(int ID);
        public abstract bool Insert();
        public abstract DataSet Select(int ID);
        public abstract bool Delete(int ID);
       

    }
}