using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.EntityFrameworkCore;
using MySql.Data.MySqlClient;
using Nop.Core.Data;
using Nop.Core.Domain.Common;
using Nop.Core.Infrastructure;
using Nop.Data.Extensions;

namespace Nop.Data
{
    public partial class MySqlDataProvider : IDataProvider
    {
        public bool BackupSupported => throw new NotImplementedException();

        public int SupportedLengthOfBinaryHash => throw new NotImplementedException();

        public DbParameter GetParameter()
        {
            return new MySqlParameter();
        }

        public void InitializeDatabase()
        {
            //throw new NotImplementedException();
            var context = EngineContext.Current.Resolve<IDbContext>();
            
            // SELECT  FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='当前数据库' AND table_type = 'BASE TABLE'
            //check some of table names to ensure that we have nopCommerce 2.00+ installed
            var tableNamesToValidate = new List<string> { "Customer", "Discount", "Order", "Product", "ShoppingCartItem" };
            var existingTableNames = context
                .QueryFromSql<StringQueryType>($"SELECT table_name AS Value FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = '{context.DbName()}' AND table_type = 'BASE TABLE'")
                .Select(stringValue => stringValue.Value).ToList();
            var createTables = !existingTableNames.Intersect(tableNamesToValidate, StringComparer.InvariantCultureIgnoreCase).Any();
            if (!createTables)
                return;

            var fileProvider = EngineContext.Current.Resolve<INopFileProvider>();

            //create tables
            //EngineContext.Current.Resolve<IRelationalDatabaseCreator>().CreateTables();
            //(context as DbContext).Database.EnsureCreated();
            var sql = context.GenerateCreateScript();
            //var dbContext = context as DbContext;
            //if (dbContext != null)
            //    dbContext.Database.SetCommandTimeout(180);
            //context.ExecuteSqlScript(sql);

            var sqlCommands = GetCommandsFromScript(sql);
            foreach (var command in sqlCommands)
                context.ExecuteSqlCommand(command);

            ////create indexes
            //context.ExecuteSqlScriptFromFile(fileProvider.MapPath(NopDataDefaults.SqlServerIndexesFilePath));

            ////create stored procedures 
            //context.ExecuteSqlScriptFromFile(fileProvider.MapPath(NopDataDefaults.SqlServerStoredProceduresFilePath));
        }


        private static IList<string> GetCommandsFromScript(string sql)
        {
            var commands = new List<string>();

            //origin from the Microsoft.EntityFrameworkCore.Migrations.SqlServerMigrationsSqlGenerator.Generate method
            sql = Regex.Replace(sql, @"\\\r?\n", string.Empty);
            var batches = Regex.Split(sql, @"^\s*(\);[ \t]+[0-9]+|\);)(?:\s+|$)", RegexOptions.IgnoreCase | RegexOptions.Multiline);

            for (var i = 0; i < batches.Length; i++)
            {
                if (string.IsNullOrWhiteSpace(batches[i]) || batches[i].StartsWith(");", StringComparison.OrdinalIgnoreCase))
                    continue;

                var count = 1;
                var builder = new StringBuilder();
                for (var j = 0; j < count; j++)
                {
                    builder.Append(batches[i]);
                    if (i == batches.Length - 1)
                        builder.AppendLine();
                    else
                        builder.Append(");");
                }

                commands.Add(builder.ToString());
            }

            return commands;
        }
    }
}
