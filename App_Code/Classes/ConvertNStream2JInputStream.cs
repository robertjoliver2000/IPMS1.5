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
    /// Transforms a .Net inputStream into a Java InputStream
    /// </summary>
    public class ConvertNStream2JInputStream : InputStream
    {
        Stream stream;

        public ConvertNStream2JInputStream(Stream stream)
        {
            this.stream = stream;
        }

        public override int read()
        {
            return stream.ReadByte();
        }

    }
}