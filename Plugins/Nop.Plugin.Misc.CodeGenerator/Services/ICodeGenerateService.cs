using Microsoft.EntityFrameworkCore.Scaffolding.Metadata;
using Nop.Plugin.Misc.CodeGenerator.Domain;
using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Services
{
    public partial interface ICodeGenerateService
    {
        IList<TableSchema> GetTables();
        //DatabaseModel GetDatabaseModel(string tableName = null);

        IList<ColumnSchema> GetColumns(string tableName);
    }
}
