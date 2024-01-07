prompt --application/shared_components/security/app_access_control/contributor
begin
--   Manifest
--     ACL ROLE: Contributor
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>5694472783606833
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'ORAMON'
);
wwv_flow_imp_shared.create_acl_role(
 p_id=>wwv_flow_imp.id(5995418108676397)
,p_static_id=>'CONTRIBUTOR'
,p_name=>'Contributor'
,p_description=>'Role assigned to application contributors.'
,p_version_scn=>341534376
);
wwv_flow_imp.component_end;
end;
/