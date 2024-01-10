prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>5694472783606833
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'ORAMON'
);
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'Dashboard'
,p_alias=>'DASHBOARD'
,p_step_title=>'Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'04'
,p_last_updated_by=>'UHELLSTR'
,p_last_upd_yyyymmddhh24miss=>'20240105111651'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6204795274686746)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(5816736520676222)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(5701034573676186)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(5879177870676239)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6205443902686747)
,p_plug_name=>'Memory Usage'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(5804317599676220)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(6205821749686747)
,p_region_id=>wwv_flow_imp.id(6205443902686747)
,p_chart_type=>'area'
,p_title=>'Memory Usage'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'Memory Usage'
,p_legend_position=>'top'
,p_time_axis_type=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6209098152695204)
,p_chart_id=>wwv_flow_imp.id(6205821749686747)
,p_seq=>10
,p_name=>'Free Memory'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', physical_memory_mb',
', free_memory_mb',
', inactive_memory_mb',
', swap_free_mb',
', host_name',
', instance_name',
'from oramon_memusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'FREE_MEMORY_MB'
,p_group_name_column_name=>'FREE_MEMORY_MB'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6209109247695205)
,p_chart_id=>wwv_flow_imp.id(6205821749686747)
,p_seq=>20
,p_name=>'Swap Free'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', physical_memory_mb',
', free_memory_mb',
', inactive_memory_mb',
', swap_free_mb',
', host_name',
', instance_name',
'from oramon_memusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;'))
,p_max_row_count=>337
,p_items_value_column_name=>'SWAP_FREE_MB'
,p_group_name_column_name=>'SWAP_FREE_MB'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6207513250686748)
,p_chart_id=>wwv_flow_imp.id(6205821749686747)
,p_seq=>30
,p_name=>'Physical Memory'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', physical_memory_mb',
', free_memory_mb',
', inactive_memory_mb',
', swap_free_mb',
', host_name',
', instance_name',
'from oramon_memusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'PHYSICAL_MEMORY_MB'
,p_group_name_column_name=>'PHYSICAL_MEMORY_MB'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6206391521686747)
,p_chart_id=>wwv_flow_imp.id(6205821749686747)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Date'
,p_format_type=>'date-short'
,p_numeric_pattern=>'RRRR-MM-DD HH24:MI:SS'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6206911525686747)
,p_chart_id=>wwv_flow_imp.id(6205821749686747)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>true
,p_zoom_order_weeks=>true
,p_zoom_order_months=>true
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6209239829695206)
,p_plug_name=>'CPU  Usage'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(5804317599676220)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(6209384330695207)
,p_region_id=>wwv_flow_imp.id(6209239829695206)
,p_chart_type=>'area'
,p_title=>'CPU Usage'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'CPU Usage'
,p_legend_position=>'top'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6209476286695208)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_seq=>10
,p_name=>'Load'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', load',
', pct_busy',
', pct_user',
', pct_sys',
', pct_iowt',
', pct_cpuwt',
', host_name',
', instance_name',
'from',
'  oramon_cpuusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'LOAD'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6210069961695214)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_seq=>20
,p_name=>'PCT  IOwt'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', load',
', pct_busy',
', pct_user',
', pct_sys',
', pct_iowt',
', pct_cpuwt',
', host_name',
', instance_name',
'from',
'  oramon_cpuusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'PCT_IOWT'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6209585722695209)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_seq=>30
,p_name=>'PCT Busy'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', load',
', pct_busy',
', pct_user',
', pct_sys',
', pct_iowt',
', pct_cpuwt',
', host_name',
', instance_name',
'from',
'  oramon_cpuusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'PCT_BUSY'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6209641040695210)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_seq=>40
,p_name=>'PCT User'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', load',
', pct_busy',
', pct_user',
', pct_sys',
', pct_iowt',
', pct_cpuwt',
', host_name',
', instance_name',
'from',
'  oramon_cpuusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'PCT_USER'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6209993109695213)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_seq=>50
,p_name=>'PCT  Sys'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', load',
', pct_busy',
', pct_user',
', pct_sys',
', pct_iowt',
', pct_cpuwt',
', host_name',
', instance_name',
'from',
'  oramon_cpuusage',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>48
,p_ajax_items_to_submit=>'337'
,p_items_value_column_name=>'PCT_SYS'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6209792174695211)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Date'
,p_format_type=>'date-short'
,p_numeric_pattern=>'RRRR-MM-DD HH24:MI:SS'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6209868585695212)
,p_chart_id=>wwv_flow_imp.id(6209384330695207)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6210155979695215)
,p_plug_name=>'SQL Executions per second'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(5804317599676220)
,p_plug_display_sequence=>90
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(6210288834695216)
,p_region_id=>wwv_flow_imp.id(6210155979695215)
,p_chart_type=>'line'
,p_title=>'SQL Executions per second'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'CPU Usage'
,p_legend_position=>'top'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6210335721695217)
,p_chart_id=>wwv_flow_imp.id(6210288834695216)
,p_seq=>10
,p_name=>'SQL Executions per second'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', diff_value',
', to_number(exec_per_sec) exec_per_sec',
', host_name',
', instance_name',
'from',
'  oramon_exec_per_seconds',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'EXEC_PER_SEC'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6210840059695222)
,p_chart_id=>wwv_flow_imp.id(6210288834695216)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Date'
,p_format_type=>'date-short'
,p_numeric_pattern=>'RRRR-MM-DD HH24:MI:SS'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6210996402695223)
,p_chart_id=>wwv_flow_imp.id(6210288834695216)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6211013848695224)
,p_plug_name=>'Logons / Open Cursors'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(5804317599676220)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(6211194281695225)
,p_region_id=>wwv_flow_imp.id(6211013848695224)
,p_chart_type=>'line'
,p_title=>'Logons / Open Cursors'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'CPU Usage'
,p_legend_position=>'top'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6211205899695226)
,p_chart_id=>wwv_flow_imp.id(6211194281695225)
,p_seq=>10
,p_name=>'Logons'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', value',
', host_name',
', instance_name',
'from',
'  oramon_logons',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'VALUE'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6211334629695227)
,p_chart_id=>wwv_flow_imp.id(6211194281695225)
,p_seq=>20
,p_name=>'Open Cursors'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', value',
', host_name',
', instance_name',
'from',
'  oramon_open_cursors',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'VALUE'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6211446412695228)
,p_chart_id=>wwv_flow_imp.id(6211194281695225)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Date'
,p_format_type=>'date-short'
,p_numeric_pattern=>'RRRR-MM-DD HH24:MI:SS'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6211582914695229)
,p_chart_id=>wwv_flow_imp.id(6211194281695225)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6211698914695230)
,p_plug_name=>'SGA Memory'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(5804317599676220)
,p_plug_display_sequence=>60
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(6211714164695231)
,p_region_id=>wwv_flow_imp.id(6211698914695230)
,p_chart_type=>'area'
,p_title=>'SGA Memory'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'CPU Usage'
,p_legend_position=>'top'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6211896128695232)
,p_chart_id=>wwv_flow_imp.id(6211714164695231)
,p_seq=>10
,p_name=>'Database Buffers'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', name',
', (to_number(bval) / 1024 ) / 1024 as bval',
', host_name',
', instance_name',
'from oramon_sga_memory',
'where name = ''Database Buffers''',
'  and snap_time between :P2_START and :P2_END',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'BVAL'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6212225995695236)
,p_chart_id=>wwv_flow_imp.id(6211714164695231)
,p_seq=>20
,p_name=>'Variable Size'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', name',
', (to_number(bval) / 1024 ) / 1024 as bval',
', host_name',
', instance_name',
'from oramon_sga_memory',
'where name = ''Variable Size''',
'  and snap_time between :P2_START and :P2_END',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'BVAL'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'none'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6212313467695237)
,p_chart_id=>wwv_flow_imp.id(6211714164695231)
,p_seq=>30
,p_name=>'Redo Buffers'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', name',
', (to_number(bval) / 1024 ) / 1024 as bval',
', host_name',
', instance_name',
'from oramon_sga_memory',
'where name = ''Redo Buffers''',
'  and snap_time between :P2_START and :P2_END',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'BVAL'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'none'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(6212463319695238)
,p_chart_id=>wwv_flow_imp.id(6211714164695231)
,p_seq=>40
,p_name=>'Fixed Size'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', name',
', (to_number(bval) / 1024 ) / 1024 as bval',
', host_name',
', instance_name',
'from oramon_sga_memory',
'where name = ''Fixed Size''',
'  and snap_time between :P2_START and :P2_END',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'BVAL'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'none'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6212090636695234)
,p_chart_id=>wwv_flow_imp.id(6211714164695231)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Date'
,p_format_type=>'date-short'
,p_numeric_pattern=>'RRRR-MM-DD HH24:MI:SS'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(6212141878695235)
,p_chart_id=>wwv_flow_imp.id(6211714164695231)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'MB'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6213581995695249)
,p_plug_name=>'Hit Ratio'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(5804317599676220)
,p_plug_display_sequence=>120
,p_plug_new_grid_row=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(6213653061695250)
,p_region_id=>wwv_flow_imp.id(6213581995695249)
,p_chart_type=>'line'
,p_title=>'Hit Ratio %'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'Hit Ratio %'
,p_legend_position=>'top'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(8197287983821801)
,p_chart_id=>wwv_flow_imp.id(6213653061695250)
,p_seq=>10
,p_name=>'Database Buffers Hit Ratio'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', to_number(buffer_hit,''9.999'',''nls_numeric_characters=''''.,'''''') * 100 buffer_hit',
', host_name',
', instance_name',
'from oramon_buffer_hit_ratio',
' where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id;',
''))
,p_max_row_count=>337
,p_items_value_column_name=>'BUFFER_HIT'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(8197879091821807)
,p_chart_id=>wwv_flow_imp.id(6213653061695250)
,p_seq=>20
,p_name=>'Database Buffers Pin Hit Ratio_'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', to_number(pinhitrate,''9.999'',''nls_numeric_characters=''''.,'''''') * 100 pinhitratio',
', to_number(gethitrate,''9.999'',''nls_numeric_characters=''''.,'''''') * 100 gethitratio',
', host_name',
', instance_name',
'from oramon_buffer_pin_get_hit_ratio',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id'))
,p_max_row_count=>337
,p_items_value_column_name=>'PINHITRATIO'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(8197922849821808)
,p_chart_id=>wwv_flow_imp.id(6213653061695250)
,p_seq=>30
,p_name=>'Database Buffers Get Hit Ratio'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  snap_id',
', snap_time',
', to_number(pinhitrate,''9.999'',''nls_numeric_characters=''''.,'''''') * 100 pinhitratio',
', to_number(gethitrate,''9.999'',''nls_numeric_characters=''''.,'''''') * 100 gethitratio',
', host_name',
', instance_name',
'from oramon_buffer_pin_get_hit_ratio',
'where snap_time between to_date(:P2_START,''RRRR-MM-DD HH24:MI:SS'') and to_date(:P2_END,''RRRR-MM-DD HH24:MI:SS'')',
'order by snap_id'))
,p_max_row_count=>337
,p_items_value_column_name=>'GETHITRATIO'
,p_group_short_desc_column_name=>'SNAP_TIME'
,p_items_label_column_name=>'SNAP_TIME'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(8197634207821805)
,p_chart_id=>wwv_flow_imp.id(6213653061695250)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Date'
,p_format_type=>'date-short'
,p_numeric_pattern=>'RRRR-MM-DD HH24:MI:SS'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(8197717779821806)
,p_chart_id=>wwv_flow_imp.id(6213653061695250)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Percent'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6212677326695240)
,p_button_sequence=>10
,p_button_name=>'Today'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(5877565614676239)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Today'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6213014136695244)
,p_button_sequence=>30
,p_button_name=>'Two-days'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(5877565614676239)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'+1 Day'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6212592071695239)
,p_button_sequence=>40
,p_button_name=>'Three-Days'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(5877565614676239)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'+3 days'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6212744925695241)
,p_button_sequence=>50
,p_button_name=>'Week'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(5877565614676239)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Week'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6212813489695242)
,p_name=>'P2_START'
,p_item_sequence=>60
,p_item_display_point=>'AFTER_NAVIGATION_BAR'
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6212993008695243)
,p_name=>'P2_END'
,p_item_sequence=>70
,p_item_display_point=>'AFTER_NAVIGATION_BAR'
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(8200053694821829)
,p_name=>'set-start-today'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(6212677326695240)
,p_bind_type=>'one'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8200144592821830)
,p_event_id=>wwv_flow_imp.id(8200053694821829)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'set-start-date'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_START,P2_END'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select trunc(sysdate),sysdate from dual;'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(8200282662821831)
,p_name=>'set-start-yesterday'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(6213014136695244)
,p_bind_type=>'one'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8200397308821832)
,p_event_id=>wwv_flow_imp.id(8200282662821831)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'set-start-yesterdat'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_START,P2_END'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select trunc(sysdate-1),sysdate from dual;'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp.component_end;
end;
/
begin
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>5694472783606833
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'ORAMON'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(8198163389821810)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'default_chart_range'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  select trunc(sysdate) into :P2_START from dual;',
'  select sysdate into :P2_END from dual;',
' end;'))
,p_process_clob_language=>'PLSQL'
,p_process_is_stateful_y_n=>'Y'
,p_internal_uid=>8198163389821810
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(8199019312821819)
,p_process_sequence=>20
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'default_today'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  select trunc(sysdate) into :P2_START from dual;',
'  select sysdate into :P2_END from dual;',
' end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(6212677326695240)
,p_internal_uid=>8199019312821819
);
wwv_flow_imp.component_end;
end;
/
