using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Nop.Web.Areas.Admin.Models.Common
{
    public partial class TableSchemaModel
    {
        public string Name { get; set; }
        public string StoreType { get; set; }

        public string NativeType { get; set; }

        public string DotnetType { get; set; }

        public string Comment { get; set; }


        private IList<TableSchemaModel> _columns;

      
        public virtual IList<TableSchemaModel> Columns
        {
            get => _columns ?? (_columns = new List<TableSchemaModel>());
            set => _columns = value;
        }
    }
}
