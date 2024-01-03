prompt --workspace/credentials/app_102_push_notifications_credentials
begin
--   Manifest
--     CREDENTIAL: App 102 Push Notifications Credentials
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>5694472783606833
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'ORAMON'
);
wwv_imp_workspace.create_credential(
 p_id=>wwv_flow_imp.id(6203172618676590)
,p_name=>'App 102 Push Notifications Credentials'
,p_static_id=>'App_102_Push_Notifications_Credentials'
,p_authentication_type=>'KEY_PAIR'
,p_prompt_on_install=>false
);
wwv_flow_imp.component_end;
end;
/
