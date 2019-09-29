using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Nop.Web.Areas.Admin.Models.Common
{
    public partial class ColumnSchemaModel
    {
        public string Name { get; set; }
        public string StoreType { get; set; }

        public string NativeType { get; set; }

        public string DotnetType { get; set; }

        public string Comment { get; set; }
    }
}
