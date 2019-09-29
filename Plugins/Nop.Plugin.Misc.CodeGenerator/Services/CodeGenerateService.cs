using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Scaffolding;
using Microsoft.EntityFrameworkCore.Scaffolding.Metadata;
using Microsoft.Extensions.Logging;
using Nop.Core.Caching;
using Nop.Core.Data;
using Nop.Core.Infrastructure;
using Nop.Data;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Nop.Data.Extensions;
using System.Linq;
using Nop.Core.Domain.Common;
using Nop.Plugin.Misc.CodeGenerator.Domain;

namespace Nop.Plugin.Misc.CodeGenerator.Services
{
    public partial class CodeGenerateService: ICodeGenerateService
    {

        #region Fields

        private readonly IStaticCacheManager _cacheManager;
        private readonly IDbContext _dbContext;

        //private readonly ILoggerFactory _loggerFactory;
        //private readonly Microsoft.Extensions.Logging.ILogger _logger;
        //private readonly IDiagnosticsLogger<DbLoggerCategory.Scaffolding> _diagnosticsLogger;

        #endregion

        #region Ctor

        public CodeGenerateService(IDbContext dbContext,
            //ILoggerFactory loggerFactory,
            IStaticCacheManager cacheManager)
        {
            _dbContext = dbContext;
            _cacheManager = cacheManager;
            //_loggerFactory = loggerFactory;
            //_logger = loggerFactory.CreateLogger<CodeGenerateService>(); // logger;

            //_diagnosticsLogger = new DiagnosticsLogger<DbLoggerCategory.Scaffolding>(loggerFactory, new LoggingOptions(), new DiagnosticListener(""));
        }

        #endregion

        //private IDatabaseModelFactory GetDatabaseModelFactory(DataProviderType dataProviderType)
        //{

        //    switch (dataProviderType)
        //    {
        //        case DataProviderType.Unknown:
        //            return new Microsoft.EntityFrameworkCore.SqlServer.Scaffolding.Internal.SqlServerDatabaseModelFactory(_diagnosticsLogger);

        //        //break;
        //        case DataProviderType.SqlServer:
        //            return new Microsoft.EntityFrameworkCore.SqlServer.Scaffolding.Internal.SqlServerDatabaseModelFactory(_diagnosticsLogger);
        //        //break;

        //        case DataProviderType.MySql:
        //            return new Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal.MySqlDatabaseModelFactory(_loggerFactory);
        //        //break;
        //        case DataProviderType.PostgreSql:
        //            return new Microsoft.EntityFrameworkCore.SqlServer.Scaffolding.Internal.SqlServerDatabaseModelFactory(_diagnosticsLogger);

        //        //break;
        //        default:
        //            return new Microsoft.EntityFrameworkCore.SqlServer.Scaffolding.Internal.SqlServerDatabaseModelFactory(_diagnosticsLogger);

        //            //break;
        //    }
        //}

        //private DatabaseModel GetDatabaseModel(IDatabaseModelFactory factory, string connectionString, string tableName)
        //{
        //    //return factory.Create(dataSettings.DataConnectionString, new List<string>(), new List<string>());// database.Tables, database.Schemas);
        //    return factory.Create(connectionString, new string[] { tableName }, new string[] { _dbContext.DbName() });
        //}

        //public DatabaseModel GetDatabaseModel(string tableName = null)
        //{
        //    var cacheTime = 3;

        //    var databaseModel = _cacheManager.Get($"DatabaseModel-{tableName}", () =>
        //    {
        //        var dataSettings = DataSettingsManager.LoadSettings();

        //        var factory = GetDatabaseModelFactory(dataSettings.DataProvider);
        //        var model = GetDatabaseModel(factory, dataSettings.DataConnectionString, tableName);

        //        if (model == null)
        //            throw new InvalidOperationException("Failed to create database model");
        //        return model;
        //    }, cacheTime);

        //    return databaseModel;
        //}

        public IList<TableSchema> GetTables()
        {
            var cacheTime = 3;
            var tables = _cacheManager.Get("DatabaseTables", () =>
            {
                var dataSettings = DataSettingsManager.LoadSettings();
                var sql = "SELECT TABLE_NAME AS TableName FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_TYPE = 'BASE TABLE' AND ( TABLE_SCHEMA = '{0}' OR TABLE_CATALOG = '{0}')";
                switch (dataSettings.DataProvider)
                {
                    case DataProviderType.Unknown:
                    case DataProviderType.SqlServer:
                        sql = "SELECT TABLE_NAME AS TableName, '' AS Comment FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = '{0}'";
                        break;
                    case DataProviderType.MySql:
                        sql = "SELECT TABLE_NAME AS TableName, TABLE_COMMENT AS Comment FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = '{0}'";
                        break;
                    case DataProviderType.PostgreSql:
                        break;
                    default:
                        sql = "SELECT TABLE_NAME AS TableName FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_TYPE = 'BASE TABLE' AND ( TABLE_SCHEMA = '{0}' OR TABLE_CATALOG = '{0}')";
                        break;
                }
                var result = _dbContext.QueryFromSql<TableSchema>(string.Format(sql, _dbContext.DbName())).ToList();
                if(dataSettings.DataProvider == DataProviderType.SqlServer)
                {
                    sql = "SELECT d.name AS TableName, f.value AS Comment FROM  sysobjects d INNER JOIN sys.extended_properties f ON d.id=f.major_id AND f.minor_id=0";
                    var comments = _dbContext.QueryFromSql<TableSchema>(sql).ToList();
                    foreach(var c in comments)
                    {
                        var table = result.FirstOrDefault(t => t.TableName == c.TableName);
                        if (table != null)
                            table.Comment = c.Comment;
                    }
                }
                return result.ToList();
            }, cacheTime);
            return tables;
        }
        public IList<ColumnSchema> GetColumns(string tableName)
        {
            var cacheTime = 3;

            var tables = _cacheManager.Get("DatabaseColumns", () =>
            {
                var dataSettings = DataSettingsManager.LoadSettings();

                //var result1 = _dbContext.QueryFromSql<StringQueryType>(string.Format("SELECT TABLE_NAME AS VALUE FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_TYPE = 'BASE TABLE' AND ( TABLE_SCHEMA = '{0}' OR TABLE_CATALOG = '{0}')",
                //    _dbContext.DbName()))
                //    .ToList();
                // TABLE_NAME AS TableName, 
                var sql = @"SELECT  COLUMN_NAME AS ColumnName, CAST(ORDINAL_POSITION AS SIGNED) AS OrdinalPosition, IS_NULLABLE AS IsNullable, DATA_TYPE AS DataType,  CAST(CHARACTER_MAXIMUM_LENGTH AS SIGNED) AS ColumnLength, '' AS DotnetType, 0 AS IsPrimaryKey, COLUMN_COMMENT AS Comment FROM INFORMATION_SCHEMA.COLUMNS ";
                switch (dataSettings.DataProvider)
                {
                    case DataProviderType.Unknown:
                    case DataProviderType.SqlServer:
                        sql = @"SELECT  COLUMN_NAME AS ColumnName, CAST(ORDINAL_POSITION AS INT)  AS OrdinalPosition, IS_NULLABLE AS IsNullable, DATA_TYPE AS DataType,  CAST(CHARACTER_MAXIMUM_LENGTH AS INT) AS ColumnLength, '' AS DotnetType, CAST(0 AS BIT) AS IsPrimaryKey, '' AS Comment FROM INFORMATION_SCHEMA.COLUMNS ";
                        sql += " WHERE TABLE_CATALOG = '{0}' AND  TABLE_NAME = '{1}'";
                        break;
                    case DataProviderType.MySql:
                        sql += " WHERE TABLE_SCHEMA = '{0}' AND  TABLE_NAME = '{1}'";
                        break;
                    case DataProviderType.PostgreSql:
                        break;
                    default:
                        sql += " WHERE (TABLE_CATALOG = '{0}' OR TABLE_SCHEMA = '{0}') AND  TABLE_NAME = '{1}'";
                        break;
                }
                var result = _dbContext.QueryFromSql<ColumnSchema>(string.Format(sql, _dbContext.DbName(), tableName))
                      //.Select(stringValue => stringValue.Value)
                      .ToList();

                // return result;//.ToList();

                // 主键
                sql = " SELECT COLUMN_NAME AS Value FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE ";
                switch (dataSettings.DataProvider)
                {
                    case DataProviderType.Unknown:
                    case DataProviderType.SqlServer:
                        sql += " WHERE TABLE_CATALOG = '{0}' AND  TABLE_NAME = '{1}'  AND CONSTRAINT_NAME = 'PRIMARY'";
                        break;
                    case DataProviderType.MySql:
                        sql += " WHERE TABLE_SCHEMA = '{0}' AND  TABLE_NAME = '{1}'  AND CONSTRAINT_NAME = 'PRIMARY'";
                        break;
                    case DataProviderType.PostgreSql:
                        break;
                    default:
                        sql += " WHERE (TABLE_CATALOG = '{0}' OR TABLE_SCHEMA = '{0}') AND  TABLE_NAME = '{1}'  AND CONSTRAINT_NAME = 'PRIMARY'";
                        break;
                }
                var primaryResult = _dbContext.QueryFromSql<StringQueryType>(string.Format(sql, _dbContext.DbName(), tableName))
                      .Select(stringValue => stringValue.Value).FirstOrDefault();//.ToList();
                if(!String.IsNullOrEmpty(primaryResult))
                {
                    var keyColumn = result.FirstOrDefault(t => t.ColumnName == primaryResult);
                    if (keyColumn != null)
                        keyColumn.IsPrimaryKey = true;
                }
                // 
                if (dataSettings.DataProvider == DataProviderType.SqlServer)
                {
                    // t.name AS TableName,
                    sql = @"SELECT c.name AS ColumnName, 0 AS OrdinalPosition, 'YES' AS IsNullable, '' AS DataType,  0 AS ColumnLength, '' AS DotnetType, CAST(0 AS BIT) AS IsPrimaryKey, d.value AS Comment FROM sys.columns c INNER JOIN sys.tables t ON t.object_id = c.object_id  INNER JOIN sys.extended_properties d ON d.major_id = c.object_id AND d.minor_id = c.column_id  WHERE t.name = '{0}' ";
                    var comments = _dbContext.QueryFromSql<ColumnSchema>(string.Format(sql, tableName)).ToList();
                    foreach (var desc in comments)
                    {
                        var column = result.FirstOrDefault(c => c.ColumnName == desc.ColumnName);
                        if (column != null)
                            column.Comment = desc.Comment;
                    }
                }

                return result;
            }, cacheTime);

            return tables;
        }

    }
}
