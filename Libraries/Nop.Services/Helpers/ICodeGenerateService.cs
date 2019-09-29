using Microsoft.EntityFrameworkCore.Scaffolding.Metadata;
using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Services.Helpers
{
    public partial interface ICodeGenerateService
    {
        IList<string> GetTables();
        DatabaseModel GetDatabaseModel(string tableName = null);
    }
}
