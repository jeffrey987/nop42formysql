using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Models
{
    //class GenerateCodeType
    //{
    //}
    public enum GenerateCodeType
    {
        /// <summary>
        /// 
        /// </summary>
        Interface = 10,
        /// <summary>
        /// 
        /// </summary>
        Service = 20,
        /// <summary>
        /// 正常部门
        /// </summary>
        Model = 30,

        Controller = 40,

        Validator = 50,

        View = 60,

        MapperConfiguration = 70,

        Resource = 80
    }
}
