echo "crating tablespace and user"
sqlplus sys/admin@orcl as sysdba @.\00_create_tablespace_and_user.sql

echo "creating user objects"
sqlplus SPERP/SPERP@orcl @.\01_user_object\01_create_tables.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\02_create_sequence.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\03_create_type.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\04_create_function.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\05_create_procedure.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\06_create_views.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\07_create_trigger.sql
sqlplus SPERP/SPERP@orcl @.\01_user_object\09_create_activiti.sql

echo "import initial data"
sqlplus SPERP/SPERP@orcl @.\02_table_data\01_sy_admin.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\02_sy_menu.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\03_sy_code.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\04_sy_login_screen.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\05_sy_screen_grant.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\06_process_ess_ralation.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\07_serial_num.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\08_ar_calender_type.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\09_sy_parameter.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\10_process_object_type.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\11_sy_admin_deptid.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\12_att.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\13_pa_distinct_list.sql
sqlplus SPERP/SPERP@orcl @.\02_table_data\14_prostor_sales_model.sql