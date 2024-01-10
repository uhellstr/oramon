prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_default_workspace_id=>5694472783606833
);
end;
/
prompt  WORKSPACE 5694472783606833
--
-- Workspace, User Group, User, and Team Development Export:
--   Exported By:     ULFDBA
--   Export Type:     Workspace Export
--   Version:         23.2.0
--   Instance ID:     2802367672142301
--
-- Import:
--   Using Instance Administration / Manage Workspaces
--   or
--   Using SQL*Plus as the Oracle user APEX_230200
 
begin
    wwv_flow_imp.set_security_group_id(p_security_group_id=>5694472783606833);
end;
/
----------------
-- W O R K S P A C E
-- Creating a workspace will not create database schemas or objects.
-- This API creates only the meta data for this APEX workspace
prompt  Creating workspace ORAMON...
begin
wwv_flow_fnd_user_api.create_company (
  p_id => 5694596040606848
 ,p_provisioning_company_id => 5694472783606833
 ,p_short_name => 'ORAMON'
 ,p_display_name => 'ORAMON'
 ,p_first_schema_provisioned => 'ORAMON'
 ,p_company_schemas => 'ORAMON'
 ,p_account_status => 'ASSIGNED'
 ,p_allow_plsql_editing => 'Y'
 ,p_allow_app_building_yn => 'Y'
 ,p_allow_packaged_app_ins_yn => 'Y'
 ,p_allow_sql_workshop_yn => 'Y'
 ,p_allow_team_development_yn => 'Y'
 ,p_allow_to_be_purged_yn => 'Y'
 ,p_allow_restful_services_yn => 'Y'
 ,p_source_identifier => 'ORAMON'
 ,p_webservice_logging_yn => 'Y'
 ,p_path_prefix => 'ORAMON'
 ,p_files_version => 1
 ,p_env_banner_yn => 'N'
 ,p_env_banner_pos => 'LEFT'
);
end;
/
----------------
-- G R O U P S
--
prompt  Creating Groups...
begin
wwv_flow_fnd_user_api.create_user_group (
  p_id => 5402644598189923,
  p_GROUP_NAME => 'OAuth2 Client Developer',
  p_SECURITY_GROUP_ID => 10,
  p_GROUP_DESC => 'Users authorized to register OAuth2 Client Applications');
end;
/
begin
wwv_flow_fnd_user_api.create_user_group (
  p_id => 5402535665189923,
  p_GROUP_NAME => 'RESTful Services',
  p_SECURITY_GROUP_ID => 10,
  p_GROUP_DESC => 'Users authorized to use RESTful Services with this workspace');
end;
/
begin
wwv_flow_fnd_user_api.create_user_group (
  p_id => 5402468079189922,
  p_GROUP_NAME => 'SQL Developer',
  p_SECURITY_GROUP_ID => 10,
  p_GROUP_DESC => 'Users authorized to use SQL Developer with this workspace');
end;
/
prompt  Creating group grants...
----------------
-- U S E R S
-- User repository for use with APEX cookie-based authentication.
--
prompt  Creating Users...
begin
wwv_flow_fnd_user_api.create_fnd_user (
  p_user_id                      => '5694390177606833',
  p_user_name                    => 'ADMIN-ORAMON',
  p_first_name                   => 'Ulf',
  p_last_name                    => 'Hellström',
  p_description                  => '',
  p_email_address                => 'oraminute@gmail.com',
  p_web_password                 => '8F29BBACC2CD367BA374FD08A026C184D24A60BA1B1EAE82FF3DF3418BC6E194E3F310EDB630F2394B919BF1CA071BEB2CE0E332C369599B62A44BE3754BCCC2',
  p_web_password_format          => '5;5;10000',
  p_group_ids                    => '',
  p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
  p_default_schema               => 'ORAMON',
  p_account_locked               => 'N',
  p_account_expiry               => to_date('202312061441','YYYYMMDDHH24MI'),
  p_failed_access_attempts       => 0,
  p_change_password_on_first_use => 'Y',
  p_first_password_use_occurred  => 'N',
  p_allow_app_building_yn        => 'Y',
  p_allow_sql_workshop_yn        => 'Y',
  p_allow_team_development_yn    => 'Y',
  p_allow_access_to_schemas      => '');
end;
/
begin
wwv_flow_fnd_user_api.create_fnd_user (
  p_user_id                      => '5695361558614602',
  p_user_name                    => 'UHELLSTR',
  p_first_name                   => 'Ulf',
  p_last_name                    => 'Hellstrom',
  p_description                  => 'Developer of ORAMON',
  p_email_address                => 'oraminute@gmail.com',
  p_web_password                 => 'FD47C6921592EEF0EB85B2CEA107B19CF8108BE1481C3FD41BD721992D04A2393FF64723482AB1DEAF25F6B9A489D5BD141B129236D26A987AF1C14CECEBEC4E',
  p_web_password_format          => '5;5;10000',
  p_group_ids                    => '',
  p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
  p_default_schema               => 'ORAMON',
  p_account_locked               => 'N',
  p_account_expiry               => to_date('202312061442','YYYYMMDDHH24MI'),
  p_failed_access_attempts       => 0,
  p_change_password_on_first_use => 'N',
  p_first_password_use_occurred  => 'N',
  p_allow_app_building_yn        => 'Y',
  p_allow_sql_workshop_yn        => 'Y',
  p_allow_team_development_yn    => 'Y',
  p_default_date_format          => 'RRRR-MM-DD HH24:MI:SS',
  p_allow_access_to_schemas      => '');
end;
/
---------------------------
-- D G  B L U E P R I N T S
-- Creating Data Generator Blueprints...
----------------
--Click Count Logs
--
----------------
--mail
--
----------------
--mail log
--
----------------
--app models
--
----------------
--password history
--
begin
  wwv_imp_workspace.create_password_history (
    p_id => 5694794707606868,
    p_user_id => 5694390177606833,
    p_password => '8F29BBACC2CD367BA374FD08A026C184D24A60BA1B1EAE82FF3DF3418BC6E194E3F310EDB630F2394B919BF1CA071BEB2CE0E332C369599B62A44BE3754BCCC2');
end;
/
begin
  wwv_imp_workspace.create_password_history (
    p_id => 5695478383614608,
    p_user_id => 5695361558614602,
    p_password => 'FD47C6921592EEF0EB85B2CEA107B19CF8108BE1481C3FD41BD721992D04A2393FF64723482AB1DEAF25F6B9A489D5BD141B129236D26A987AF1C14CECEBEC4E');
end;
/
----------------
--preferences
--
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8181838386727669,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P4100_W3727618522871356',
    p_attribute_value => '3728530690872449____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8182045640728737,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P4850_W663191354226602129',
    p_attribute_value => '663193778295677089____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8182253270731177,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P2300_W2050828593861326',
    p_attribute_value => '2117833588027975____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8182402440731183,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P2300_W92468021968325911',
    p_attribute_value => '95148537308558700____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8182604893734203,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P4047_W184800502564237029',
    p_attribute_value => '184804717913266027____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8182860558734737,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P4110_W1548412223182178',
    p_attribute_value => '1550029190194632____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8386590096499941,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P431_W478896025956673213',
    p_attribute_value => '478896612991674411____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8386680746500671,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP4000_P34_R77549119545304597_SORT',
    p_attribute_value => 'sort_1_asc',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 7949087546914772,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P405_W3852329031687921',
    p_attribute_value => '3853503855690337____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 7949412150915181,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'APEX_IG_665073618803777080_CURRENT_REPORT',
    p_attribute_value => '665079563548779201:GRID',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 7949569982918167,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'CODE_LANGUAGE',
    p_attribute_value => 'PLSQL',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 7542078047469154,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P1500_W3519715528105919',
    p_attribute_value => '3521529006112497____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8180478248689646,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P4445_W14886206368621919',
    p_attribute_value => '14887631485621929____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8180670054693513,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P273_W48571614952501952',
    p_attribute_value => '48572307979502610____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8180744784704273,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'PD_GAL_CUR_TAB',
    p_attribute_value => '0',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8180944415714617,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP4000_P445_R22486816559326797_SORT',
    p_attribute_value => 'sort_3_asc',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8181170211714790,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P473_W12979631587497157',
    p_attribute_value => '12983410815532326____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8181375679715112,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P667_W380035630081486164',
    p_attribute_value => '380036549255488918____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8181615179723523,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP4000_P197_R935666971301945228_SORT',
    p_attribute_value => 'sort_2_asc',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8183412289776553,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P546_W30205316146531602',
    p_attribute_value => '30206031208532453____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8383444254418332,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P939_W451352700445603348',
    p_attribute_value => '451353909559603360____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8999445434479008,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P516_W478906809191866600',
    p_attribute_value => '478908119205874812____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8382769741417089,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P19_W451745617575288584',
    p_attribute_value => '451746507039288843____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 6203625293676685,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'PERSISTENT_ITEM_P1_DISPLAY_MODE',
    p_attribute_value => 'ICONS',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 6203845236676698,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P1_W3326806401130228',
    p_attribute_value => '3328003692130542____',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 6203906220676714,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FB_FLOW_ID',
    p_attribute_value => '102',
    p_tenant_id => '');
end;
/
begin
  wwv_imp_workspace.create_preferences$ (
    p_id => 8999612172479613,
    p_user_id => 'UHELLSTR',
    p_preference_name => 'FSP_IR_4000_P527_W478911116494917969',
    p_attribute_value => '478911808086918993____',
    p_tenant_id => '');
end;
/
----------------
--query builder
--
----------------
--sql scripts
--
----------------
--sql commands
--
----------------
--Quick SQL saved models
--
----------------
--user access log
--
begin
  wwv_imp_workspace.create_user_access_log1$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401081916','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log1$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401101015','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log1$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202401101015','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312261441','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312281111','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312281228','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 4,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312281228','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 4,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312281336','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312291035','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312291043','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312291131','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202401021047','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401021048','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'ULFHEL',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261016','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261016','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'HELLSTULF',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261127','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'HELLSULF',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261127','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'HELLSULF',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261128','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'HELLSULF',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261128','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'HELLSULF',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261128','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'HELLSULF',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312261128','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312261129','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261129','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312261250','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312271023','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312271024','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312281111','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312281416','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312301050','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202401031018','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401031311','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401071150','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312251215','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312251216','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312290958','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401031012','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401041049','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401041456','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 4,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401041456','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202401041534','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202401051027','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202401051054','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312261255','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Oracle APEX Accounts',
    p_app => 102,
    p_owner => 'ORAMON',
    p_access_date => to_date('202312291046','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_imp_workspace.create_user_access_log2$ (
    p_login_name => 'UHELLSTR',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_230200',
    p_access_date => to_date('202312281229','YYYYMMDDHH24MI'),
    p_ip_address => '192.168.122.135',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
 
prompt ...RESTful Services
 
-- SET SCHEMA
 
begin
 
   wwv_flow_imp.g_id_offset := 0;
   wwv_flow_hint.g_schema   := 'ORAMON';
   wwv_flow_hint.check_schema_privs;
 
end;
/

 
--------------------------------------------------------------------
prompt  SCHEMA ORAMON - User Interface Defaults, Table Defaults
--
-- Import using sqlplus as the Oracle user: APEX_230200
-- Exported 10:42 Wednesday January 10, 2024 by: 
--
 
--------------------------------------------------------------------
prompt User Interface Defaults, Attribute Dictionary
--
-- Exported 10:42 Wednesday January 10, 2024 by: 
--
-- SHOW EXPORTING WORKSPACE
 
begin
 
   wwv_flow_imp.g_id_offset := 0;
   wwv_flow_hint.g_exp_workspace := 'ORAMON';
 
end;
/

begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
