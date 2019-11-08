/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3307
 Source Schema         : stsdb

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 05/11/2019 16:20:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for __efmigrationshistory
-- ----------------------------
DROP TABLE IF EXISTS `__efmigrationshistory`;
CREATE TABLE `__efmigrationshistory`  (
  `MigrationId` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`MigrationId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of __efmigrationshistory
-- ----------------------------
INSERT INTO `__efmigrationshistory` VALUES ('20191105071219_PersistedGrantInitialCreate', '2.1.11-servicing-32099');
INSERT INTO `__efmigrationshistory` VALUES ('20191105071242_ConfigInitialCreate', '2.1.11-servicing-32099');

-- ----------------------------
-- Table structure for oidc_api_resource_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_claims`;
CREATE TABLE `oidc_api_resource_claims`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_api_resource_claims_ApiResourceId`(`ApiResourceId`) USING BTREE,
  CONSTRAINT `FK_oidc_api_resource_claims_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_api_resource_claims
-- ----------------------------
INSERT INTO `oidc_api_resource_claims` VALUES (1, 'role', 3);
INSERT INTO `oidc_api_resource_claims` VALUES (2, 'admin', 4);
INSERT INTO `oidc_api_resource_claims` VALUES (3, 'role', 4);
INSERT INTO `oidc_api_resource_claims` VALUES (4, 'name', 2);
INSERT INTO `oidc_api_resource_claims` VALUES (5, 'email', 2);
INSERT INTO `oidc_api_resource_claims` VALUES (6, 'user', 3);
INSERT INTO `oidc_api_resource_claims` VALUES (7, 'user', 4);
INSERT INTO `oidc_api_resource_claims` VALUES (8, 'admin', 3);

-- ----------------------------
-- Table structure for oidc_api_resource_properties
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_properties`;
CREATE TABLE `oidc_api_resource_properties`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_api_resource_properties_ApiResourceId`(`ApiResourceId`) USING BTREE,
  CONSTRAINT `FK_oidc_api_resource_properties_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_api_resource_scope_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_scope_claims`;
CREATE TABLE `oidc_api_resource_scope_claims`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApiScopeId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_api_resource_scope_claims_ApiScopeId`(`ApiScopeId`) USING BTREE,
  CONSTRAINT `FK_oidc_api_resource_scope_claims_oidc_api_resource_scopes_ApiS~` FOREIGN KEY (`ApiScopeId`) REFERENCES `oidc_api_resource_scopes` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_api_resource_scopes
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_scopes`;
CREATE TABLE `oidc_api_resource_scopes`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DisplayName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Required` bit(1) NOT NULL,
  `Emphasize` bit(1) NOT NULL,
  `ShowInDiscoveryDocument` bit(1) NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_oidc_api_resource_scopes_Name`(`Name`) USING BTREE,
  INDEX `IX_oidc_api_resource_scopes_ApiResourceId`(`ApiResourceId`) USING BTREE,
  CONSTRAINT `FK_oidc_api_resource_scopes_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_api_resource_scopes
-- ----------------------------
INSERT INTO `oidc_api_resource_scopes` VALUES (1, 'scope_used_for_api_in_protected_zone', NULL, NULL, b'0', b'0', b'0', 4);
INSERT INTO `oidc_api_resource_scopes` VALUES (2, 'ProtectedApi', 'ProtectedApi', NULL, b'0', b'0', b'1', 4);
INSERT INTO `oidc_api_resource_scopes` VALUES (3, 'api1', 'My API', NULL, b'0', b'0', b'1', 1);
INSERT INTO `oidc_api_resource_scopes` VALUES (4, 'scope_used_for_hybrid_flow', 'scope_used_for_hybrid_flow', NULL, b'0', b'0', b'1', 3);
INSERT INTO `oidc_api_resource_scopes` VALUES (5, 'api2.read_only', 'Read only access to API 2', NULL, b'0', b'0', b'1', 2);
INSERT INTO `oidc_api_resource_scopes` VALUES (6, 'api2.full_access', 'Full access to API 2', NULL, b'0', b'0', b'1', 2);
INSERT INTO `oidc_api_resource_scopes` VALUES (7, 'nop_api', 'nop_api', NULL, b'0', b'0', b'1', 5);

-- ----------------------------
-- Table structure for oidc_api_resource_secrets
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resource_secrets`;
CREATE TABLE `oidc_api_resource_secrets`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Expiration` datetime(6) NULL DEFAULT NULL,
  `Type` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created` datetime(6) NOT NULL,
  `ApiResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_api_resource_secrets_ApiResourceId`(`ApiResourceId`) USING BTREE,
  CONSTRAINT `FK_oidc_api_resource_secrets_oidc_api_resources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `oidc_api_resources` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_api_resource_secrets
-- ----------------------------
INSERT INTO `oidc_api_resource_secrets` VALUES (1, NULL, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', NULL, 'SharedSecret', '2019-11-05 07:55:00.609536', 2);
INSERT INTO `oidc_api_resource_secrets` VALUES (2, NULL, 'lugmmQ38wx0V6SFVjzDjA9RyjBkCXM7I3Rh9dyPn6ic=', NULL, 'SharedSecret', '2019-11-05 07:55:00.620380', 4);
INSERT INTO `oidc_api_resource_secrets` VALUES (3, NULL, 'nlI3AP3+FzgJ6IlY5+dGExYg6+hEy4oPcEv04cfllF0=', NULL, 'SharedSecret', '2019-11-05 07:55:00.620183', 3);

-- ----------------------------
-- Table structure for oidc_api_resources
-- ----------------------------
DROP TABLE IF EXISTS `oidc_api_resources`;
CREATE TABLE `oidc_api_resources`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Enabled` bit(1) NOT NULL,
  `Name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DisplayName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `Updated` datetime(6) NULL DEFAULT NULL,
  `LastAccessed` datetime(6) NULL DEFAULT NULL,
  `NonEditable` bit(1) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_oidc_api_resources_Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_api_resources
-- ----------------------------
INSERT INTO `oidc_api_resources` VALUES (1, b'1', 'api1', 'My API', NULL, '2019-11-05 07:55:00.583417', NULL, NULL, b'0');
INSERT INTO `oidc_api_resources` VALUES (2, b'1', 'api2', NULL, NULL, '2019-11-05 07:55:00.609523', NULL, NULL, b'0');
INSERT INTO `oidc_api_resources` VALUES (3, b'1', 'scope_used_for_hybrid_flow', 'scope_used_for_hybrid_flow', NULL, '2019-11-05 07:55:00.620179', NULL, NULL, b'0');
INSERT INTO `oidc_api_resources` VALUES (4, b'1', 'ProtectedApi', 'API protected', NULL, '2019-11-05 07:55:00.620378', NULL, NULL, b'0');
INSERT INTO `oidc_api_resources` VALUES (5, b'1', 'nop_api', NULL, NULL, '2019-11-05 07:55:00.620557', NULL, NULL, b'0');

-- ----------------------------
-- Table structure for oidc_client_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_claims`;
CREATE TABLE `oidc_client_claims`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Value` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_claims_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_claims_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_client_cors_origins
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_cors_origins`;
CREATE TABLE `oidc_client_cors_origins`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Origin` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_cors_origins_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_cors_origins_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_client_cors_origins
-- ----------------------------
INSERT INTO `oidc_client_cors_origins` VALUES (1, 'http://localhost:5003', 9);
INSERT INTO `oidc_client_cors_origins` VALUES (2, 'https://localhost:44341', 11);

-- ----------------------------
-- Table structure for oidc_client_grant_types
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_grant_types`;
CREATE TABLE `oidc_client_grant_types`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `GrantType` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_grant_types_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_grant_types_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_client_grant_types
-- ----------------------------
INSERT INTO `oidc_client_grant_types` VALUES (1, 'client_credentials', 1);
INSERT INTO `oidc_client_grant_types` VALUES (2, 'authorization_code', 10);
INSERT INTO `oidc_client_grant_types` VALUES (3, 'authorization_code', 9);
INSERT INTO `oidc_client_grant_types` VALUES (4, 'hybrid', 4);
INSERT INTO `oidc_client_grant_types` VALUES (5, 'client_credentials', 5);
INSERT INTO `oidc_client_grant_types` VALUES (6, 'authorization_code', 11);
INSERT INTO `oidc_client_grant_types` VALUES (7, 'urn:ietf:params:oauth:grant-type:device_code', 6);
INSERT INTO `oidc_client_grant_types` VALUES (8, 'implicit', 3);
INSERT INTO `oidc_client_grant_types` VALUES (9, 'hybrid', 8);
INSERT INTO `oidc_client_grant_types` VALUES (10, 'password', 2);
INSERT INTO `oidc_client_grant_types` VALUES (11, 'authorization_code', 7);
INSERT INTO `oidc_client_grant_types` VALUES (12, 'authorization_code', 12);

-- ----------------------------
-- Table structure for oidc_client_idp_restrictions
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_idp_restrictions`;
CREATE TABLE `oidc_client_idp_restrictions`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Provider` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_idp_restrictions_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_idp_restrictions_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_client_post_logout_redirect_uris
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_post_logout_redirect_uris`;
CREATE TABLE `oidc_client_post_logout_redirect_uris`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PostLogoutRedirectUri` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_post_logout_redirect_uris_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_post_logout_redirect_uris_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_client_post_logout_redirect_uris
-- ----------------------------
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (1, 'http://localhost:5002/signout-callback-oidc', 8);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (2, 'https://localhost:5002/signout-callback-oidc', 12);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (3, 'https://localhost:5002/signout-callback-oidc', 4);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (4, 'https://localhost:44329/signout-callback-oidc', 4);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (5, 'https://localhost:44330/signout-callback-oidc', 7);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (6, 'https://localhost:44330/signout-callback-oidc', 10);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (7, 'http://localhost:5002/signout-callback-oidc', 3);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (8, 'https://localhost:44341/', 11);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (9, 'https://localhost:44341', 11);
INSERT INTO `oidc_client_post_logout_redirect_uris` VALUES (10, 'http://localhost:5003/index.html', 9);

-- ----------------------------
-- Table structure for oidc_client_properties
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_properties`;
CREATE TABLE `oidc_client_properties`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_properties_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_properties_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_client_redirect_uris
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_redirect_uris`;
CREATE TABLE `oidc_client_redirect_uris`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectUri` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_redirect_uris_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_redirect_uris_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_client_redirect_uris
-- ----------------------------
INSERT INTO `oidc_client_redirect_uris` VALUES (1, 'http://localhost:5003/callback.html', 9);
INSERT INTO `oidc_client_redirect_uris` VALUES (2, 'https://localhost:44330/signin-oidc', 7);
INSERT INTO `oidc_client_redirect_uris` VALUES (3, 'https://localhost:44330/signin-oidc', 10);
INSERT INTO `oidc_client_redirect_uris` VALUES (4, 'http://localhost:5003/callback.html', 8);
INSERT INTO `oidc_client_redirect_uris` VALUES (5, 'http://localhost:5002/signin-oidc', 8);
INSERT INTO `oidc_client_redirect_uris` VALUES (6, 'https://localhost:44341', 11);
INSERT INTO `oidc_client_redirect_uris` VALUES (7, 'https://localhost:44341/callback.html', 11);
INSERT INTO `oidc_client_redirect_uris` VALUES (8, 'https://localhost:44341/silent-renew.html', 11);
INSERT INTO `oidc_client_redirect_uris` VALUES (9, 'http://localhost:5002/signin-oidc', 9);
INSERT INTO `oidc_client_redirect_uris` VALUES (10, 'https://localhost:5002/signin-oidc', 12);
INSERT INTO `oidc_client_redirect_uris` VALUES (11, 'http://localhost:5002/signin-oidc', 3);
INSERT INTO `oidc_client_redirect_uris` VALUES (12, 'https://localhost:44329/signin-oidc', 4);
INSERT INTO `oidc_client_redirect_uris` VALUES (13, 'https://localhost:5002/signin-oidc', 4);

-- ----------------------------
-- Table structure for oidc_client_scopes
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_scopes`;
CREATE TABLE `oidc_client_scopes`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Scope` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_scopes_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_scopes_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_client_scopes
-- ----------------------------
INSERT INTO `oidc_client_scopes` VALUES (1, 'role', 7);
INSERT INTO `oidc_client_scopes` VALUES (2, 'openid', 4);
INSERT INTO `oidc_client_scopes` VALUES (3, 'profile', 3);
INSERT INTO `oidc_client_scopes` VALUES (4, 'openid', 11);
INSERT INTO `oidc_client_scopes` VALUES (5, 'dataEventRecords', 11);
INSERT INTO `oidc_client_scopes` VALUES (6, 'dataeventrecordsscope', 11);
INSERT INTO `oidc_client_scopes` VALUES (7, 'role', 11);
INSERT INTO `oidc_client_scopes` VALUES (8, 'profile', 4);
INSERT INTO `oidc_client_scopes` VALUES (9, 'profile', 11);
INSERT INTO `oidc_client_scopes` VALUES (10, 'openid', 3);
INSERT INTO `oidc_client_scopes` VALUES (11, 'offline_access', 2);
INSERT INTO `oidc_client_scopes` VALUES (12, 'api1', 2);
INSERT INTO `oidc_client_scopes` VALUES (13, 'api1', 1);
INSERT INTO `oidc_client_scopes` VALUES (14, 'openid', 12);
INSERT INTO `oidc_client_scopes` VALUES (15, 'profile', 12);
INSERT INTO `oidc_client_scopes` VALUES (16, 'offline_access', 12);
INSERT INTO `oidc_client_scopes` VALUES (17, 'api1', 12);
INSERT INTO `oidc_client_scopes` VALUES (18, 'nop_api', 12);
INSERT INTO `oidc_client_scopes` VALUES (19, 'email', 11);
INSERT INTO `oidc_client_scopes` VALUES (20, 'offline_access', 7);
INSERT INTO `oidc_client_scopes` VALUES (21, 'api1', 10);
INSERT INTO `oidc_client_scopes` VALUES (22, 'profile', 10);
INSERT INTO `oidc_client_scopes` VALUES (23, 'profile', 7);
INSERT INTO `oidc_client_scopes` VALUES (24, 'openid', 7);
INSERT INTO `oidc_client_scopes` VALUES (25, 'email', 6);
INSERT INTO `oidc_client_scopes` VALUES (26, 'openid', 8);
INSERT INTO `oidc_client_scopes` VALUES (27, 'profile', 8);
INSERT INTO `oidc_client_scopes` VALUES (28, 'profile', 6);
INSERT INTO `oidc_client_scopes` VALUES (29, 'offline_access', 10);
INSERT INTO `oidc_client_scopes` VALUES (30, 'scope_used_for_api_in_protected_zone', 5);
INSERT INTO `oidc_client_scopes` VALUES (31, 'openid', 6);
INSERT INTO `oidc_client_scopes` VALUES (32, 'profile', 9);
INSERT INTO `oidc_client_scopes` VALUES (33, 'api1', 9);
INSERT INTO `oidc_client_scopes` VALUES (34, 'role', 4);
INSERT INTO `oidc_client_scopes` VALUES (35, 'scope_used_for_hybrid_flow', 4);
INSERT INTO `oidc_client_scopes` VALUES (36, 'offline_access', 4);
INSERT INTO `oidc_client_scopes` VALUES (37, 'openid', 10);
INSERT INTO `oidc_client_scopes` VALUES (38, 'openid', 9);
INSERT INTO `oidc_client_scopes` VALUES (39, 'api1', 8);

-- ----------------------------
-- Table structure for oidc_client_secrets
-- ----------------------------
DROP TABLE IF EXISTS `oidc_client_secrets`;
CREATE TABLE `oidc_client_secrets`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Expiration` datetime(6) NULL DEFAULT NULL,
  `Type` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created` datetime(6) NOT NULL,
  `ClientId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_client_secrets_ClientId`(`ClientId`) USING BTREE,
  CONSTRAINT `FK_oidc_client_secrets_oidc_clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `oidc_clients` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_client_secrets
-- ----------------------------
INSERT INTO `oidc_client_secrets` VALUES (1, NULL, 'kb6Gzs+GHg+9gBBttGHcFjNmunfcuFBsUgsiPSVFOsQ=', NULL, 'SharedSecret', '2019-11-05 07:55:00.196627', 5);
INSERT INTO `oidc_client_secrets` VALUES (2, NULL, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', NULL, 'SharedSecret', '2019-11-05 07:55:00.181195', 2);
INSERT INTO `oidc_client_secrets` VALUES (3, NULL, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', NULL, 'SharedSecret', '2019-11-05 07:55:00.197175', 8);
INSERT INTO `oidc_client_secrets` VALUES (4, NULL, 'nlI3AP3+FzgJ6IlY5+dGExYg6+hEy4oPcEv04cfllF0=', NULL, 'SharedSecret', '2019-11-05 07:55:00.196198', 4);
INSERT INTO `oidc_client_secrets` VALUES (5, NULL, 'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=', NULL, 'SharedSecret', '2019-11-05 07:55:00.085509', 1);
INSERT INTO `oidc_client_secrets` VALUES (6, NULL, 'kJsWMk/E8Y41tj85TznsQZhGvXZIw7rjgHCfQVfiR90=', NULL, 'SharedSecret', '2019-11-05 07:55:00.203236', 10);
INSERT INTO `oidc_client_secrets` VALUES (7, NULL, 'kJsWMk/E8Y41tj85TznsQZhGvXZIw7rjgHCfQVfiR90=', NULL, 'SharedSecret', '2019-11-05 07:55:00.196917', 7);
INSERT INTO `oidc_client_secrets` VALUES (8, NULL, 'kJsWMk/E8Y41tj85TznsQZhGvXZIw7rjgHCfQVfiR90=', NULL, 'SharedSecret', '2019-11-05 07:55:00.203968', 12);

-- ----------------------------
-- Table structure for oidc_clients
-- ----------------------------
DROP TABLE IF EXISTS `oidc_clients`;
CREATE TABLE `oidc_clients`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Enabled` bit(1) NOT NULL,
  `ClientId` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProtocolType` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `RequireClientSecret` bit(1) NOT NULL,
  `ClientName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ClientUri` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `LogoUri` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `RequireConsent` bit(1) NOT NULL,
  `AllowRememberConsent` bit(1) NOT NULL,
  `AlwaysIncludeUserClaimsInIdToken` bit(1) NOT NULL,
  `RequirePkce` bit(1) NOT NULL,
  `AllowPlainTextPkce` bit(1) NOT NULL,
  `AllowAccessTokensViaBrowser` bit(1) NOT NULL,
  `FrontChannelLogoutUri` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `FrontChannelLogoutSessionRequired` bit(1) NOT NULL,
  `BackChannelLogoutUri` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `BackChannelLogoutSessionRequired` bit(1) NOT NULL,
  `AllowOfflineAccess` bit(1) NOT NULL,
  `IdentityTokenLifetime` int(11) NOT NULL,
  `AccessTokenLifetime` int(11) NOT NULL,
  `AuthorizationCodeLifetime` int(11) NOT NULL,
  `ConsentLifetime` int(11) NULL DEFAULT NULL,
  `AbsoluteRefreshTokenLifetime` int(11) NOT NULL,
  `SlidingRefreshTokenLifetime` int(11) NOT NULL,
  `RefreshTokenUsage` int(11) NOT NULL,
  `UpdateAccessTokenClaimsOnRefresh` bit(1) NOT NULL,
  `RefreshTokenExpiration` int(11) NOT NULL,
  `AccessTokenType` int(11) NOT NULL,
  `EnableLocalLogin` bit(1) NOT NULL,
  `IncludeJwtId` bit(1) NOT NULL,
  `AlwaysSendClientClaims` bit(1) NOT NULL,
  `ClientClaimsPrefix` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `PairWiseSubjectSalt` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Created` datetime(6) NOT NULL,
  `Updated` datetime(6) NULL DEFAULT NULL,
  `LastAccessed` datetime(6) NULL DEFAULT NULL,
  `UserSsoLifetime` int(11) NULL DEFAULT NULL,
  `UserCodeType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `DeviceCodeLifetime` int(11) NOT NULL,
  `NonEditable` bit(1) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_oidc_clients_ClientId`(`ClientId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_clients
-- ----------------------------
INSERT INTO `oidc_clients` VALUES (1, b'1', 'client', 'oidc', b'1', NULL, NULL, NULL, NULL, b'1', b'1', b'0', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'0', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.084901', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (2, b'1', 'ro.client', 'oidc', b'1', NULL, NULL, NULL, NULL, b'1', b'1', b'0', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 60, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.181190', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (3, b'1', 'mvc', 'oidc', b'1', 'MVC Implicit Client', NULL, NULL, NULL, b'1', b'1', b'0', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'0', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.184575', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (4, b'1', 'hybridclient', 'oidc', b'1', 'hybridclient', NULL, NULL, NULL, b'1', b'1', b'1', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'1', 1, 0, b'1', b'0', b'1', 'client_', NULL, '2019-11-05 07:55:00.196197', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (5, b'1', 'CC_FOR_API', 'oidc', b'1', 'CC_FOR_API', NULL, NULL, NULL, b'1', b'1', b'0', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'0', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.196605', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (6, b'1', 'deviceFlowWebClient', 'oidc', b'0', 'Device Flow Client', NULL, NULL, NULL, b'1', b'1', b'1', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.196771', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (7, b'1', 'codeflowpkceclient2', 'oidc', b'1', 'codeflowpkceclient2', NULL, NULL, NULL, b'1', b'1', b'1', b'1', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'1', 1, 0, b'1', b'0', b'1', 'client_', NULL, '2019-11-05 07:55:00.196916', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (8, b'1', 'mvc hybrid', 'oidc', b'1', 'MVC Hybrid Client', NULL, NULL, NULL, b'1', b'1', b'0', b'0', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.197175', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (9, b'1', 'js', 'oidc', b'0', 'JavaScript Client', NULL, NULL, NULL, b'1', b'1', b'0', b'1', b'0', b'0', NULL, b'1', NULL, b'1', b'0', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'0', 1, 0, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.197430', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (10, b'1', 'codeflowpkceclient', 'oidc', b'1', 'codeflowpkceclient', '客户端为asp.net core razor pages应用程序', NULL, NULL, b'1', b'1', b'1', b'1', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'1', 1, 0, b'1', b'0', b'1', 'client_', NULL, '2019-11-05 07:55:00.203234', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (11, b'1', 'vuejs_code_client', 'oidc', b'0', 'vuejs_code_client', '客户端为Vue应用程序', NULL, NULL, b'1', b'1', b'0', b'1', b'0', b'1', NULL, b'1', NULL, b'1', b'0', 300, 330, 300, NULL, 2592000, 1296000, 1, b'0', 1, 1, b'1', b'0', b'0', 'client_', NULL, '2019-11-05 07:55:00.203510', NULL, NULL, NULL, NULL, 300, b'0');
INSERT INTO `oidc_clients` VALUES (12, b'1', 'nop_api_client', 'oidc', b'1', 'nopcommerce api client', 'nopcommerce api client', NULL, NULL, b'1', b'1', b'1', b'1', b'0', b'0', NULL, b'1', NULL, b'1', b'1', 300, 3600, 300, NULL, 2592000, 1296000, 1, b'1', 1, 0, b'1', b'0', b'1', 'client_', NULL, '2019-11-05 07:55:00.203967', NULL, NULL, NULL, NULL, 300, b'0');

-- ----------------------------
-- Table structure for oidc_device_codess
-- ----------------------------
DROP TABLE IF EXISTS `oidc_device_codess`;
CREATE TABLE `oidc_device_codess`  (
  `DeviceCode` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserCode` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `SubjectId` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ClientId` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreationTime` datetime(6) NOT NULL,
  `Expiration` datetime(6) NOT NULL,
  `Data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`UserCode`) USING BTREE,
  UNIQUE INDEX `IX_oidc_device_codess_DeviceCode`(`DeviceCode`) USING BTREE,
  INDEX `IX_oidc_device_codess_Expiration`(`Expiration`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_identity_resource_claims
-- ----------------------------
DROP TABLE IF EXISTS `oidc_identity_resource_claims`;
CREATE TABLE `oidc_identity_resource_claims`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdentityResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_identity_resource_claims_IdentityResourceId`(`IdentityResourceId`) USING BTREE,
  CONSTRAINT `FK_oidc_identity_resource_claims_oidc_identity_resources_Identi~` FOREIGN KEY (`IdentityResourceId`) REFERENCES `oidc_identity_resources` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_identity_resource_claims
-- ----------------------------
INSERT INTO `oidc_identity_resource_claims` VALUES (1, 'sub', 1);
INSERT INTO `oidc_identity_resource_claims` VALUES (2, 'role', 4);
INSERT INTO `oidc_identity_resource_claims` VALUES (3, 'email_verified', 3);
INSERT INTO `oidc_identity_resource_claims` VALUES (4, 'email', 3);
INSERT INTO `oidc_identity_resource_claims` VALUES (5, 'updated_at', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (6, 'locale', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (7, 'zoneinfo', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (8, 'birthdate', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (9, 'gender', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (10, 'website', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (11, 'picture', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (12, 'profile', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (13, 'preferred_username', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (14, 'nickname', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (15, 'middle_name', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (16, 'given_name', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (17, 'family_name', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (18, 'name', 2);
INSERT INTO `oidc_identity_resource_claims` VALUES (19, 'admin', 4);
INSERT INTO `oidc_identity_resource_claims` VALUES (20, 'user', 4);

-- ----------------------------
-- Table structure for oidc_identity_resource_properties
-- ----------------------------
DROP TABLE IF EXISTS `oidc_identity_resource_properties`;
CREATE TABLE `oidc_identity_resource_properties`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdentityResourceId` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_oidc_identity_resource_properties_IdentityResourceId`(`IdentityResourceId`) USING BTREE,
  CONSTRAINT `FK_oidc_identity_resource_properties_oidc_identity_resources_Id~` FOREIGN KEY (`IdentityResourceId`) REFERENCES `oidc_identity_resources` (`Id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oidc_identity_resources
-- ----------------------------
DROP TABLE IF EXISTS `oidc_identity_resources`;
CREATE TABLE `oidc_identity_resources`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Enabled` bit(1) NOT NULL,
  `Name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DisplayName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Required` bit(1) NOT NULL,
  `Emphasize` bit(1) NOT NULL,
  `ShowInDiscoveryDocument` bit(1) NOT NULL,
  `Created` datetime(6) NOT NULL,
  `Updated` datetime(6) NULL DEFAULT NULL,
  `NonEditable` bit(1) NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_oidc_identity_resources_Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oidc_identity_resources
-- ----------------------------
INSERT INTO `oidc_identity_resources` VALUES (1, b'1', 'openid', 'Your user identifier', NULL, b'1', b'0', b'1', '2019-11-05 07:55:00.448933', NULL, b'0');
INSERT INTO `oidc_identity_resources` VALUES (2, b'1', 'profile', 'User profile', 'Your user profile information (first name, last name, etc.)', b'0', b'1', b'1', '2019-11-05 07:55:00.474475', NULL, b'0');
INSERT INTO `oidc_identity_resources` VALUES (3, b'1', 'email', 'Your email address', NULL, b'0', b'1', b'1', '2019-11-05 07:55:00.481995', NULL, b'0');
INSERT INTO `oidc_identity_resources` VALUES (4, b'1', 'my_identity_scope', 'my_identity_scope', NULL, b'0', b'0', b'1', '2019-11-05 07:55:00.489839', NULL, b'0');

-- ----------------------------
-- Table structure for oidc_persisted_grants
-- ----------------------------
DROP TABLE IF EXISTS `oidc_persisted_grants`;
CREATE TABLE `oidc_persisted_grants`  (
  `Key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `SubjectId` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ClientId` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreationTime` datetime(6) NOT NULL,
  `Expiration` datetime(6) NULL DEFAULT NULL,
  `Data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Key`) USING BTREE,
  INDEX `IX_oidc_persisted_grants_SubjectId_ClientId_Type_Expiration`(`SubjectId`, `ClientId`, `Type`, `Expiration`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
