using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Domain
{
    public partial class ColumnSchema
    {
        //public string TableName { get; set; }
        public string ColumnName { get; set; }

        public int OrdinalPosition { get; set; }

        /// <summary>
        ///  NO or YES
        /// </summary>
        public string IsNullable { get; set; }

        public string DataType { get; set; }

        public int? ColumnLength { get; set; }

        public string DotnetType { get; set; }

        public bool IsPrimaryKey { get; set; }

        public string Comment { get; set; }
    }
}
