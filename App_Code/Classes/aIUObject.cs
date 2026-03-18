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
    /// Summary description for aIUObject
    /// </summary>
    public abstract class aIUObject : aDatabaseObject 
    {
        public aIUObject()
        {
            // underlying objects are already instantiated by the aDatabaseObject abstract class
        }

        public abstract int Commit();
        public abstract bool Validate();
        public abstract int  GetMyFaultStatus();
        public abstract DataSet  GetAllFaults();
        public abstract DataSet  GetMyFaults();
        protected abstract bool PopulateFromDataRow(DataRow dr);
        public abstract int PopulateFromDataSet(DataSet ds, int UploadID);



        public override bool Update(int ID)
        {
            throw new Exception("The method or operation is not implemented.");
        }

        public override bool Insert()
        {
            throw new Exception("The method or operation is not implemented.");
        }

        public override DataSet Select(int ID)
        {
            throw new Exception("The method or operation is not implemented.");
        }

        public override bool Delete(int ID)
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
