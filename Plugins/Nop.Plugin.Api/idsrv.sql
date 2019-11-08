/*
Navicat MySQL Data Transfer

Source Server         : 251
Source Server Version : 50710
Source Host           : 192.168.0.251:3306
Source Database       : idsrv

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2019-10-28 16:34:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for oidc_api_resources
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resources`;
CREATE TABLE `oidc_api_resources` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Enabled` bit(1) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `DisplayName` varchar(200) DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `Updated` datetime(6) DEFAULT NULL,
  `LastAccessed` datetime(6) DEFAULT NULL,
  `NonEditable` bit(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_oidc_api_resources_Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_api_resources
-- ----------------------------
INSERT INTO `oidc_api_resources` VALUES ('1', '', 'api1', 'My API', null, '2019-10-28 08:32:41.426288', null, null, '\0');

-- ----------------------------
-- Table structure for oidc_api_resource_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_claims`;
CREATE TABLE `oidc_api_resource_claims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_api_resource_claims_ApiResourceId` (`ApiResourceId`),
  CONSTRAINT `FK_oidc_api_resource_claims_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_api_resource_claims
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_api_resource_properties
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_properties`;
CREATE TABLE `oidc_api_resource_properties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(250) NOT NULL,
  `Value` varchar(2000) NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_api_resource_properties_ApiResourceId` (`ApiResourceId`),
  CONSTRAINT `FK_oidc_api_resource_properties_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_api_resource_properties
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_api_resource_scopes
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_scopes`;
CREATE TABLE `oidc_api_resource_scopes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) NOT NULL,
  `DisplayName` varchar(200) DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `Required` bit(1) NOT NULL,
  `Emphasize` bit(1) NOT NULL,
  `ShowInDiscoveryDocument` bit(1) NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_oidc_api_resource_scopes_Name` (`Name`),
  KEY `IX_oidc_api_resource_scopes_ApiResourceId` (`ApiResourceId`),
  CONSTRAINT `FK_oidc_api_resource_scopes_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_api_resource_scopes
-- ----------------------------
INSERT INTO `oidc_api_resource_scopes` VALUES ('1', 'api1', 'My API', null, '\0', '\0', '', '1');

-- ----------------------------
-- Table structure for oidc_api_resource_scope_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_scope_claims`;
CREATE TABLE `oidc_api_resource_scope_claims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) NOT NULL,
  `ApiScopeId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_api_resource_scope_claims_ApiScopeId` (`ApiScopeId`),
  CONSTRAINT `FK_oidc_api_resource_scope_claims_oidc_api_resource_scopes_ApiS~` FOREIGN KEY (`ApiScopeId`) REFERENCES `oidc_api_resource_scopes` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_api_resource_scope_claims
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_api_resource_secrets
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_secrets`;
CREATE TABLE `oidc_api_resource_secrets` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(1000) DEFAULT NULL,
  `Value` longtext NOT NULL,
  `Expiration` datetime(6) DEFAULT NULL,
  `Type` varchar(250) NOT NULL,
  `Created` datetime(6) NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_api_resource_secrets_ApiResourceId` (`ApiResourceId`),
  CONSTRAINT `FK_oidc_api_resource_secrets_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_api_resource_secrets
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_clients
-- ----------------------------
DROP TABLE IF EXISTS `oidc_clients`;
CREATE TABLE `oidc_clients` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Enabled` bit(1) NOT NULL,
  `ClientId` varchar(200) NOT NULL,
  `ProtocolType` varchar(200) NOT NULL,
  `RequireClientSecret` bit(1) NOT NULL,
  `ClientName` varchar(200) DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `ClientUri` varchar(2000) DEFAULT NULL,
  `LogoUri` varchar(2000) DEFAULT NULL,
  `RequireConsent` bit(1) NOT NULL,
  `AllowRememberConsent` bit(1) NOT NULL,
  `AlwaysIncludeUserClaimsInIdToken` bit(1) NOT NULL,
  `RequirePkce` bit(1) NOT NULL,
  `AllowPlainTextPkce` bit(1) NOT NULL,
  `AllowAccessTokensViaBrowser` bit(1) NOT NULL,
  `FrontChannelLogoutUri` varchar(2000) DEFAULT NULL,
  `FrontChannelLogoutSessionRequired` bit(1) NOT NULL,
  `BackChannelLogoutUri` varchar(2000) DEFAULT NULL,
  `BackChannelLogoutSessionRequired` bit(1) NOT NULL,
  `AllowOfflineAccess` bit(1) NOT NULL,
  `IdentityTokenLifetime` int(11) NOT NULL,
  `AccessTokenLifetime` int(11) NOT NULL,
  `AuthorizationCodeLifetime` int(11) NOT NULL,
  `ConsentLifetime` int(11) DEFAULT NULL,
  `AbsoluteRefreshTokenLifetime` int(11) NOT NULL,
  `SlidingRefreshTokenLifetime` int(11) NOT NULL,
  `RefreshTokenUsage` int(11) NOT NULL,
  `UpdateAccessTokenClaimsOnRefresh` bit(1) NOT NULL,
  `RefreshTokenExpiration` int(11) NOT NULL,
  `AccessTokenType` int(11) NOT NULL,
  `EnableLocalLogin` bit(1) NOT NULL,
  `IncludeJwtId` bit(1) NOT NULL,
  `AlwaysSendClientClaims` bit(1) NOT NULL,
  `ClientClaimsPrefix` varchar(200) DEFAULT NULL,
  `PairWiseSubjectSalt` varchar(200) DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `Updated` datetime(6) DEFAULT NULL,
  `LastAccessed` datetime(6) DEFAULT NULL,
  `UserSsoLifetime` int(11) DEFAULT NULL,
  `UserCodeType` varchar(100) DEFAULT NULL,
  `DeviceCodeLifetime` int(11) NOT NULL,
  `NonEditable` bit(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_oidc_clients_ClientId` (`ClientId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_clients
-- ----------------------------
INSERT INTO `oidc_clients` VALUES ('1', '', 'client', 'oidc', '', null, null, null, null, '', '', '\0', '\0', '\0', '\0', null, '', null, '', '\0', '300', '3600', '300', null, '2592000', '1296000', '1', '\0', '1', '0', '', '\0', '\0', 'client_', null, '2019-10-28 08:32:24.995905', null, null, null, null, '300', '\0');
INSERT INTO `oidc_clients` VALUES ('2', '', 'ro.client', 'oidc', '', null, null, null, null, '', '', '\0', '\0', '\0', '\0', null, '', null, '', '', '300', '60', '300', null, '2592000', '1296000', '1', '\0', '1', '0', '', '\0', '\0', 'client_', null, '2019-10-28 08:32:25.736455', null, null, null, null, '300', '\0');
INSERT INTO `oidc_clients` VALUES ('3', '', 'mvc', 'oidc', '', 'MVC Client', null, null, null, '', '', '\0', '\0', '\0', '\0', null, '', null, '', '\0', '300', '3600', '300', null, '2592000', '1296000', '1', '\0', '1', '0', '', '\0', '\0', 'client_', null, '2019-10-28 08:32:25.741356', null, null, null, null, '300', '\0');
INSERT INTO `oidc_clients` VALUES ('4', '', 'mvc hybrid', 'oidc', '', 'MVC Hybrid Client', null, null, null, '', '', '\0', '\0', '\0', '\0', null, '', null, '', '', '300', '3600', '300', null, '2592000', '1296000', '1', '\0', '1', '0', '', '\0', '\0', 'client_', null, '2019-10-28 08:32:25.759544', null, null, null, null, '300', '\0');
INSERT INTO `oidc_clients` VALUES ('5', '', 'js', 'oidc', '\0', 'JavaScript Client', null, null, null, '', '', '\0', '', '\0', '\0', null, '', null, '', '\0', '300', '3600', '300', null, '2592000', '1296000', '1', '\0', '1', '0', '', '\0', '\0', 'client_', null, '2019-10-28 08:32:25.760193', null, null, null, null, '300', '\0');
INSERT INTO `oidc_clients` VALUES ('6', '', 'codeflowpkceclient', 'oidc', '', 'codeflowpkceclient', '客户端为asp.net core razor pages应用程序', null, null, '', '', '', '', '\0', '\0', null, '', null, '', '', '300', '3600', '300', null, '2592000', '1296000', '1', '', '1', '0', '', '\0', '', 'client_', null, '2019-10-28 08:32:25.772787', null, null, null, null, '300', '\0');
INSERT INTO `oidc_clients` VALUES ('7', '', 'vuejs_code_client', 'oidc', '\0', 'vuejs_code_client', '客户端为Vue应用程序', null, null, '', '', '\0', '', '\0', '', null, '', null, '', '\0', '300', '330', '300', null, '2592000', '1296000', '1', '\0', '1', '1', '', '\0', '\0', 'client_', null, '2019-10-28 08:32:25.773350', null, null, null, null, '300', '\0');

-- ----------------------------
-- Table structure for oidc_client_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_claims`;
CREATE TABLE `oidc_client_claims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(250) NOT NULL,
  `Value` varchar(250) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_claims_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_claims_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_claims
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_client_cors_origins
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_cors_origins`;
CREATE TABLE `oidc_client_cors_origins` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Origin` varchar(150) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_cors_origins_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_cors_origins_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_cors_origins
-- ----------------------------
INSERT INTO `oidc_client_cors_origins` VALUES ('1', 'http://localhost:5003', '5');
INSERT INTO `oidc_client_cors_origins` VALUES ('2', 'https://localhost:44341', '7');

-- ----------------------------
-- Table structure for oidc_client_grant_types
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_grant_types`;
CREATE TABLE `oidc_client_grant_types` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `GrantType` varchar(250) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_grant_types_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_grant_types_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_grant_types
-- ----------------------------
INSERT INTO `oidc_client_grant_types` VALUES ('1', 'hybrid', '4');
INSERT INTO `oidc_client_grant_types` VALUES ('2', 'authorization_code', '6');
INSERT INTO `oidc_client_grant_types` VALUES ('3', 'authorization_code', '5');
INSERT INTO `oidc_client_grant_types` VALUES ('4', 'implicit', '3');
INSERT INTO `oidc_client_grant_types` VALUES ('5', 'client_credentials', '1');
INSERT INTO `oidc_client_grant_types` VALUES ('6', 'password', '2');
INSERT INTO `oidc_client_grant_types` VALUES ('7', 'authorization_code', '7');

-- ----------------------------
-- Table structure for oidc_client_idp_restrictions
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_idp_restrictions`;
CREATE TABLE `oidc_client_idp_restrictions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Provider` varchar(200) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_idp_restrictions_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_idp_restrictions_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_idp_restrictions
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_client_post_logout_redirect_uris
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_post_logout_redirect_uris`;
CREATE TABLE `oidc_client_post_logout_redirect_uris` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PostLogoutRedirectUri` varchar(2000) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_post_logout_redirect_uris_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_post_logout_redirect_uris_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_post_logout_redirect_uris
-- ----------------------------
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES ('1', 'https://localhost:44341/', '7');
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES ('2', 'http://localhost:5002/signout-callback-oidc', '3');
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES ('3', 'https://localhost:44341', '7');
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES ('4', 'http://localhost:5003/index.html', '5');
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES ('5', 'http://localhost:5002/signout-callback-oidc', '4');
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES ('6', 'https://localhost:44330/signout-callback-oidc', '6');

-- ----------------------------
-- Table structure for oidc_client_properties
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_properties`;
CREATE TABLE `oidc_client_properties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(250) NOT NULL,
  `Value` varchar(2000) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_properties_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_properties_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_properties
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_client_redirect_uris
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_redirect_uris`;
CREATE TABLE `oidc_client_redirect_uris` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectUri` varchar(2000) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_redirect_uris_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_redirect_uris_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_redirect_uris
-- ----------------------------
INSERT INTO `oidc_client_redirect_uris` VALUES ('1', 'https://localhost:44330/signin-oidc', '6');
INSERT INTO `oidc_client_redirect_uris` VALUES ('2', 'https://localhost:44341', '7');
INSERT INTO `oidc_client_redirect_uris` VALUES ('3', 'http://localhost:5002/signin-oidc', '5');
INSERT INTO `oidc_client_redirect_uris` VALUES ('4', 'http://localhost:5003/callback.html', '5');
INSERT INTO `oidc_client_redirect_uris` VALUES ('5', 'https://localhost:44341/callback.html', '7');
INSERT INTO `oidc_client_redirect_uris` VALUES ('6', 'https://localhost:44341/silent-renew.html', '7');
INSERT INTO `oidc_client_redirect_uris` VALUES ('7', 'http://localhost:5002/signin-oidc', '4');
INSERT INTO `oidc_client_redirect_uris` VALUES ('8', 'http://localhost:5002/signin-oidc', '3');
INSERT INTO `oidc_client_redirect_uris` VALUES ('9', 'http://localhost:5003/callback.html', '4');

-- ----------------------------
-- Table structure for oidc_client_scopes
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_scopes`;
CREATE TABLE `oidc_client_scopes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Scope` varchar(200) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_scopes_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_scopes_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_scopes
-- ----------------------------
INSERT INTO `oidc_client_scopes` VALUES ('1', 'api1', '1');
INSERT INTO `oidc_client_scopes` VALUES ('2', 'api1', '2');
INSERT INTO `oidc_client_scopes` VALUES ('3', 'email', '7');
INSERT INTO `oidc_client_scopes` VALUES ('4', 'profile', '7');
INSERT INTO `oidc_client_scopes` VALUES ('5', 'role', '7');
INSERT INTO `oidc_client_scopes` VALUES ('6', 'dataeventrecordsscope', '7');
INSERT INTO `oidc_client_scopes` VALUES ('7', 'dataEventRecords', '7');
INSERT INTO `oidc_client_scopes` VALUES ('8', 'openid', '7');
INSERT INTO `oidc_client_scopes` VALUES ('9', 'offline_access', '2');
INSERT INTO `oidc_client_scopes` VALUES ('10', 'openid', '3');
INSERT INTO `oidc_client_scopes` VALUES ('11', 'offline_access', '6');
INSERT INTO `oidc_client_scopes` VALUES ('12', 'profile', '6');
INSERT INTO `oidc_client_scopes` VALUES ('13', 'openid', '6');
INSERT INTO `oidc_client_scopes` VALUES ('14', 'openid', '4');
INSERT INTO `oidc_client_scopes` VALUES ('15', 'profile', '4');
INSERT INTO `oidc_client_scopes` VALUES ('16', 'api1', '4');
INSERT INTO `oidc_client_scopes` VALUES ('17', 'api1', '5');
INSERT INTO `oidc_client_scopes` VALUES ('18', 'openid', '5');
INSERT INTO `oidc_client_scopes` VALUES ('19', 'profile', '3');
INSERT INTO `oidc_client_scopes` VALUES ('20', 'profile', '5');

-- ----------------------------
-- Table structure for oidc_client_secrets
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_secrets`;
CREATE TABLE `oidc_client_secrets` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(2000) DEFAULT NULL,
  `Value` longtext NOT NULL,
  `Expiration` datetime(6) DEFAULT NULL,
  `Type` varchar(250) NOT NULL,
  `Created` datetime(6) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_client_secrets_ClientId` (`ClientId`),
  CONSTRAINT `FK_oidc_client_secrets_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_client_secrets
-- ----------------------------
INSERT INTO `oidc_client_secrets` VALUES ('1', null, 'kJsWMk/E8Y41tj85TznsQZhGvXZIw7rjgHCfQVfiR90=', null, 'SharedSecret', '2019-10-28 08:32:25.772789', '6');
INSERT INTO `oidc_client_secrets` VALUES ('2', null, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', null, 'SharedSecret', '2019-10-28 08:32:25.736466', '2');
INSERT INTO `oidc_client_secrets` VALUES ('3', null, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', null, 'SharedSecret', '2019-10-28 08:32:25.759546', '4');
INSERT INTO `oidc_client_secrets` VALUES ('4', null, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', null, 'SharedSecret', '2019-10-28 08:32:24.996627', '1');

-- ----------------------------
-- Table structure for oidc_device_codess
-- ----------------------------
DROP TABLE IF EXISTS `oidc_device_codess`;
CREATE TABLE `oidc_device_codess` (
  `DeviceCode` varchar(200) NOT NULL,
  `UserCode` varchar(200) NOT NULL,
  `SubjectId` varchar(200) DEFAULT NULL,
  `ClientId` varchar(200) NOT NULL,
  `CreationTime` datetime(6) NOT NULL,
  `Expiration` datetime(6) NOT NULL,
  `Data` longtext NOT NULL,
  PRIMARY KEY (`UserCode`),
  UNIQUE KEY `IX_oidc_device_codess_DeviceCode` (`DeviceCode`),
  KEY `IX_oidc_device_codess_Expiration` (`Expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_device_codess
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_identity_resources
-- ----------------------------
DROP TABLE IF EXISTS `oidc_identity_resources`;
CREATE TABLE `oidc_identity_resources` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Enabled` bit(1) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `DisplayName` varchar(200) DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `Required` bit(1) NOT NULL,
  `Emphasize` bit(1) NOT NULL,
  `ShowInDiscoveryDocument` bit(1) NOT NULL,
  `Created` datetime(6) NOT NULL,
  `Updated` datetime(6) DEFAULT NULL,
  `NonEditable` bit(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_oidc_identity_resources_Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_identity_resources
-- ----------------------------
INSERT INTO `oidc_identity_resources` VALUES ('1', '', 'openid', 'Your user identifier', null, '', '\0', '', '2019-10-28 08:32:35.098069', null, '\0');
INSERT INTO `oidc_identity_resources` VALUES ('2', '', 'profile', 'User profile', 'Your user profile information (first name, last name, etc.)', '\0', '', '', '2019-10-28 08:32:35.152197', null, '\0');

-- ----------------------------
-- Table structure for oidc_identity_resource_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_identity_resource_claims`;
CREATE TABLE `oidc_identity_resource_claims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) NOT NULL,
  `IdentityResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_identity_resource_claims_IdentityResourceId` (`IdentityResourceId`),
  CONSTRAINT `FK_oidc_identity_resource_claims_oidc_identity_resources_Identi~` FOREIGN KEY (`IdentityResourceId`) REFERENCES `oidc_identity_resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_identity_resource_claims
-- ----------------------------
INSERT INTO `oidc_identity_resource_claims` VALUES ('1', 'sub', '1');
INSERT INTO `oidc_identity_resource_claims` VALUES ('2', 'name', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('3', 'family_name', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('4', 'given_name', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('5', 'middle_name', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('6', 'nickname', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('7', 'preferred_username', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('8', 'profile', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('9', 'picture', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('10', 'website', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('11', 'gender', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('12', 'birthdate', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('13', 'zoneinfo', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('14', 'locale', '2');
INSERT INTO `oidc_identity_resource_claims` VALUES ('15', 'updated_at', '2');

-- ----------------------------
-- Table structure for oidc_identity_resource_properties
-- ----------------------------
DROP TABLE IF EXISTS `oidc_identity_resource_properties`;
CREATE TABLE `oidc_identity_resource_properties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(250) NOT NULL,
  `Value` varchar(2000) NOT NULL,
  `IdentityResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_oidc_identity_resource_properties_IdentityResourceId` (`IdentityResourceId`),
  CONSTRAINT `FK_oidc_identity_resource_properties_oidc_identity_resources_Id~` FOREIGN KEY (`IdentityResourceId`) REFERENCES `oidc_identity_resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_identity_resource_properties
-- ----------------------------

-- ----------------------------
-- Table structure for oidc_persisted_grants
-- ----------------------------
DROP TABLE IF EXISTS `oidc_persisted_grants`;
CREATE TABLE `oidc_persisted_grants` (
  `Key` varchar(200) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `SubjectId` varchar(200) DEFAULT NULL,
  `ClientId` varchar(200) NOT NULL,
  `CreationTime` datetime(6) NOT NULL,
  `Expiration` datetime(6) DEFAULT NULL,
  `Data` longtext NOT NULL,
  PRIMARY KEY (`Key`),
  KEY `IX_oidc_persisted_grants_SubjectId_ClientId_Type_Expiration` (`SubjectId`,`ClientId`,`Type`,`Expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oidc_persisted_grants
-- ----------------------------

-- ----------------------------
-- Table structure for __efmigrationshistory
-- ----------------------------
DROP TABLE IF EXISTS `__efmigrationshistory`;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(95) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of __efmigrationshistory
-- ----------------------------
INSERT INTO `__efmigrationshistory` VALUES ('20191028080820_PersistedGrantInitialCreate', '2.1.11-servicing-32099');
INSERT INTO `__efmigrationshistory` VALUES ('20191028080846_ConfigInitialCreate', '2.1.11-servicing-32099');
