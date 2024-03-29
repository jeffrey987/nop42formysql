﻿using Nop.Core.Configuration;
using System.Security.Cryptography;
using Essensoft.AspNetCore.Payment.Security;
using Microsoft.Extensions.Logging;

namespace Nop.Plugin.Payments.AliPay
{
    public partial class AliPayPaymentSettings : ISettings
    {
        internal RSAParameters PrivateRSAParameters;
        internal RSAParameters PublicRSAParameters;

        private string rsaPrivateKey;
        private string rsaPublicKey;

        /// <summary>
        /// 应用ID
        /// </summary>
        public string AppId { get; set; }

        /// <summary>
        /// 支付宝公钥
        /// </summary>
        public string RsaPublicKey
        {
            get => rsaPublicKey;
            set
            {
                rsaPublicKey = value;
                if (!string.IsNullOrEmpty(rsaPublicKey))
                {
                    PublicRSAParameters = RSAUtilities.GetRSAParametersFormPublicKey(RsaPublicKey);
                }
            }
        }

        /// <summary>
        /// 应用私钥
        /// </summary>
        public string RsaPrivateKey
        {
            get => rsaPrivateKey;
            set
            {
                rsaPrivateKey = value;
                if (!string.IsNullOrEmpty(rsaPrivateKey))
                {
                    PrivateRSAParameters = RSAUtilities.GetRSAParametersFormPrivateKey(rsaPrivateKey);
                }
            }
        }

        /// <summary>
        /// 服务地址
        /// </summary>
        public string ServerUrl { get; set; } = "https://openapi.alipay.com/gateway.do"; // https://openapi.alipay.com/gateway.do

        /// <summary>
        /// 数据格式
        /// </summary>
        public string Format { get; set; } = "json";

        /// <summary>
        /// 接口版本
        /// </summary>
        public string Version { get; set; } = "1.0";

        /// <summary>
        /// 签名方式
        /// </summary>
        public string SignType { get; set; } = "RSA2";

        /// <summary>
        /// 编码格式
        /// </summary>
        public string Charset { get; } = "utf-8";

        /// <summary>
        /// 加密方式
        /// </summary>
        public string EncyptType { get; } = "AES";

        /// <summary>
        /// 加密秘钥
        /// </summary>
        public string EncyptKey { get; set; }

        /// <summary>
        /// 日志等级
        /// </summary>
        public LogLevel LogLevel { get; set; } = LogLevel.Error;

        /// <summary>
        /// Gets or sets a value indicating whether to "additional fee" is specified as percentage. true - percentage, false - fixed value.
        /// </summary>
        public bool AdditionalFeePercentage { get; set; }

        /// <summary>
        /// Gets or sets an additional fee
        /// </summary>
        public decimal AdditionalFee { get; set; }

        public string ReturnRouteName { get; set; }
    }
}
