using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Models
{
    public partial class ColumnSchemaModel
    {
        public string TableName { get; set; }
        public string ColumnName { get; set; }

        public int OrdinalPosition { get; set; }

        public bool IsNullable { get; set; }

        public string DataType { get; set; }

        public int ColumnLength { get; set; } 

        public string DotnetType { get; set; }

        public string Comment { get; set; }
    }
}
