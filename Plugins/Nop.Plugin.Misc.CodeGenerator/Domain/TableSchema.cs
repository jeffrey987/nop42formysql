using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Domain
{
    public partial class TableSchema
    {
        public string TableName { get; set; }
        //public string StoreType { get; set; }

        //public string NativeType { get; set; }

        //public string DotnetType { get; set; }

        public string Comment { get; set; }

        private IList<ColumnSchema> _columns;

        public virtual IList<ColumnSchema> Columns
        {
            get => _columns ?? (_columns = new List<ColumnSchema>());
            set => _columns = value;
        }
    }
}
