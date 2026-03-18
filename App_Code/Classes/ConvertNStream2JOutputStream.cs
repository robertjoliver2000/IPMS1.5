using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using java.io;

namespace ProjectPortfolio.Classes
{
    /// <summary>
    /// Transforms a .Net inputStream into a Java OutputStream
    /// </summary>
    public class ConvertNStream2JOutputStream : OutputStream
    {
        Stream stream;

        public ConvertNStream2JOutputStream(Stream stream)
        {
            this.stream = stream;
        }

        public override void write(int i)
        {
            stream.WriteByte((byte)i);
        }

    }
}