prompt PL/SQL Developer import file
prompt Created on 2014Äê5ÔÂ4ÈÕ by Wzh
set feedback off
set define off
prompt Disabling triggers for SY_SCREEN_GRANT...
alter table SY_SCREEN_GRANT disable all triggers;
prompt Disabling foreign key constraints for SY_SCREEN_GRANT...
alter table SY_SCREEN_GRANT disable constraint FK_SY_SCREEN_GRANT;
prompt Deleting SY_SCREEN_GRANT...
delete from SY_SCREEN_GRANT;
commit;
prompt Loading SY_SCREEN_GRANT...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0104', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 11:07:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0800', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0802', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0803', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0804', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0805', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0806', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0807', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0808', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0809', '10', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 10:20:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0210', '11', 1, 0, 0, 0, 0, 0, to_date('16-08-2012 15:56:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:28:38', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0104', '11', 1, 0, 0, 0, 0, 0, to_date('16-08-2012 15:56:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:28:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0000', '8', 1, 1, 1, 1, 1, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0100', '8', 1, 1, 1, 1, 1, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0101', '8', 1, 0, 1, 1, 1, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0102', '8', 1, 1, 1, 1, 1, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0200', '8', 1, 1, 0, 1, 0, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0201', '8', 1, 1, 0, 0, 0, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0202', '8', 1, 0, 0, 1, 0, 0, to_date('20-11-2012 11:10:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0116', '10', 1, 1, 1, 1, 0, 0, to_date('24-10-2013 16:45:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('02-01-2014 15:40:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0115', '10', 1, 0, 0, 0, 1, 0, to_date('03-09-2013 14:37:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 13:55:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('08-10-2012 16:04:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('08-10-2012 16:04:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0207', '9', 1, 1, 1, 0, 0, 0, to_date('22-09-2013 15:34:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-10-2013 10:20:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '3', 0, 0, 0, 0, 0, 0, to_date('25-10-2012 17:31:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '10', 1, 0, 0, 0, 0, 0, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-08-2012 18:30:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '10', 1, 0, 1, 1, 1, 0, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 10:45:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '10', 0, 1, 0, 0, 0, 0, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('10-09-2013 11:19:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '10', 0, 0, 1, 1, 1, 0, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('10-09-2013 11:18:59', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0100', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 13:34:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0101', '11', 1, 1, 0, 0, 0, 0, null, null, to_date('15-08-2013 11:28:35', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0102', '11', 1, 0, 1, 1, 0, 0, null, null, null, null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0203', '11', 1, 1, 1, 1, 1, 0, to_date('17-10-2013 10:40:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-10-2013 10:43:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0106', '11', 1, 1, 0, 0, 0, 0, null, null, to_date('16-08-2012 16:00:36', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0107', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 13:34:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0110', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 13:34:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0203', '8', 1, 0, 0, 0, 0, 0, to_date('16-10-2013 10:09:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0202', '9', 1, 1, 1, 0, 1, 0, null, null, to_date('06-07-2012 10:30:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0200', '11', 1, 1, 1, 1, 1, 0, null, null, to_date('16-08-2012 15:56:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0201', '11', 1, 0, 0, 0, 0, 0, null, null, to_date('25-09-2013 15:34:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0205', '11', 1, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 16:32:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0300', '11', 1, 0, 1, 1, 1, 0, null, null, null, null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0302', '11', 1, 0, 1, 1, 1, 0, null, null, null, null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0303', '11', 0, 1, 1, 1, 1, 0, null, null, to_date('16-08-2012 15:52:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0304', '11', 1, 0, 1, 1, 1, 0, null, null, null, null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0305', '11', 0, 0, 1, 1, 1, 0, null, null, to_date('16-08-2012 15:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0306', '11', 0, 0, 1, 1, 1, 0, null, null, to_date('15-08-2012 16:34:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0201', '4', 1, 1, 0, 0, 0, 0, to_date('28-09-2013 17:09:33', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-09-2013 17:09:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
commit;
prompt 100 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:46:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:46:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('11-09-2013 16:44:13', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0000', '18', 0, 0, 0, 0, 0, 0, to_date('11-10-2012 11:52:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:44:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0810', '10', 1, 0, 0, 0, 0, 0, to_date('23-09-2013 13:49:28', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-09-2013 13:49:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0100', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0101', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ass0204', '8', 1, 0, 0, 0, 0, 0, to_date('16-10-2013 10:42:28', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0107', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0110', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0200', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0201', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0000', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0100', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0101', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0200', '18', 0, 0, 0, 0, 0, 0, null, null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '2', 0, 0, 0, 1, 0, 0, null, null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('06-09-2013 15:12:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '2', 0, 1, 1, 0, 1, 0, null, null, to_date('06-09-2013 15:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '2', 0, 0, 1, 1, 1, 0, null, null, to_date('06-09-2013 15:15:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '11', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:14:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '2', 1, 0, 0, 0, 0, 0, null, null, to_date('14-08-2013 09:14:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '2', 0, 1, 0, 0, 0, 0, null, null, to_date('29-09-2013 14:15:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0200', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 09:49:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0201', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 09:49:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0900', '203', 1, 0, 0, 0, 0, 0, to_date('07-08-2013 11:01:33', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0901', '203', 1, 0, 0, 0, 0, 0, to_date('07-08-2013 11:01:33', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0902', '203', 1, 0, 0, 0, 0, 0, to_date('08-08-2013 09:38:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0117', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 200 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:20:43', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '11', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 09:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 09:18:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0810', '1', 0, 0, 0, 0, 0, 0, to_date('25-09-2013 10:25:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0115', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0101', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0402', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0800', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0802', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0810', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0803', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0804', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0805', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0806', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0807', '3', 0, 0, 0, 0, 0, 0, to_date('27-09-2013 12:55:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0115', '2', 0, 0, 0, 0, 0, 0, to_date('25-09-2013 09:47:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 14:45:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0000', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 09:49:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0100', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 09:49:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0101', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 09:49:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0306', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0200', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0210', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0104', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0205', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0201', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0106', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0114', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0307', '11', 0, 1, 1, 1, 1, 0, to_date('18-10-2013 11:31:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-10-2013 11:44:51', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0300', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '9', 0, 0, 0, 0, 0, 0, to_date('06-07-2012 10:30:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '2', 1, 0, 0, 0, 0, 0, to_date('29-10-2012 09:37:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:13:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '18', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:38:13', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0300', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0102', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0303', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0304', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0305', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0302', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0306', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0101', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0104', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0205', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0106', '9', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:02:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0300', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0102', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0303', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0304', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0305', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0302', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0306', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 300 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0104', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0205', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0106', '18', 0, 0, 0, 0, 0, 0, to_date('16-08-2012 17:05:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2012 17:05:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0300', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0102', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0303', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0304', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0305', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0302', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0306', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0200', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0101', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0205', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0201', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0106', '10', 0, 0, 0, 0, 0, 0, to_date('30-08-2012 17:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:41:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:41:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '18', 0, 1, 1, 0, 1, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0700', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:08', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0701', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:08', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '2', 0, 0, 0, 0, 0, 0, to_date('08-01-2013 16:56:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-09-2013 09:08:13', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0702', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:08', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0703', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:08', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '2', 1, 0, 0, 0, 1, 0, to_date('08-01-2013 16:56:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0200', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0201', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0303', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0102', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0101', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0304', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0305', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0302', '8', 0, 0, 0, 0, 0, 0, to_date('29-09-2013 17:17:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0202', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0203', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0204', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0206', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0100', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0101', '10', 0, 0, 0, 0, 0, 0, to_date('18-01-2013 15:41:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0704', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:44:08', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:41:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '9', 0, 0, 0, 0, 0, 0, to_date('05-07-2012 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0000', '2', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0103', '4', 1, 1, 1, 1, 1, 0, to_date('26-09-2013 12:50:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-09-2013 17:39:54', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '171', 0, 0, 0, 0, 0, 0, to_date('21-01-2013 11:46:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-01-2013 11:46:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0201', '18', 0, 0, 0, 0, 0, 0, to_date('26-09-2013 19:44:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:44:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0202', '18', 0, 0, 0, 0, 0, 0, to_date('26-09-2013 19:44:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:44:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0300', '18', 0, 0, 0, 0, 0, 0, to_date('26-09-2013 19:44:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:44:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0301', '18', 0, 0, 0, 0, 0, 0, to_date('26-09-2013 19:44:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:44:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0000', '188', 1, 0, 0, 0, 0, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0100', '188', 1, 0, 0, 0, 0, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0101', '188', 1, 0, 1, 1, 1, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:04:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0102', '188', 1, 0, 0, 0, 0, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0200', '188', 1, 0, 0, 0, 0, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0201', '188', 0, 1, 0, 0, 0, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:04:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0000', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0100', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0101', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0102', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0103', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0104', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0200', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0201', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0202', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:54:54', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0000', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('doc0202', '188', 0, 1, 0, 0, 0, 0, to_date('22-04-2013 15:03:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-04-2013 15:04:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0100', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0101', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0103', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 400 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0104', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0300', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0301', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 10:55:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:09:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0000', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0100', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0101', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0200', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0201', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0202', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0300', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0301', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0303', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0306', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0307', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0309', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 11:45:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 11:47:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0000', '173', 1, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0100', '173', 1, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:00:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0101', '173', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:00:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0102', '173', 1, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:00:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0103', '173', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:00:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0104', '173', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:00:30', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0105', '173', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:00:37', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0200', '173', 1, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0104', '174', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:16:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0105', '174', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:16:35', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0200', '174', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:16:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0203', '174', 1, 0, 1, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:22:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0205', '174', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:16:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0202', '2', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0203', '2', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0204', '2', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0206', '2', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0201', '18', 0, 0, 0, 0, 0, 0, to_date('26-04-2013 16:13:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0202', '18', 0, 0, 0, 0, 0, 0, to_date('26-04-2013 16:13:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0203', '18', 0, 0, 0, 0, 0, 0, to_date('26-04-2013 16:13:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0204', '18', 0, 0, 0, 0, 0, 0, to_date('26-04-2013 16:13:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0206', '18', 0, 0, 0, 0, 0, 0, to_date('26-04-2013 16:13:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-04-2013 16:13:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0000', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0100', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0101', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0102', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0200', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0201', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0202', '195', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:18:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0000', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0100', '2', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0101', '2', 1, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0000', '193', 1, 0, 0, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:49:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0100', '193', 1, 1, 1, 1, 1, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:49:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0101', '193', 1, 1, 1, 1, 1, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:49:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0200', '193', 0, 0, 0, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:50:49', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0201', '193', 0, 0, 1, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:50:49', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0202', '193', 0, 0, 0, 1, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:50:49', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0300', '193', 1, 0, 0, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:49:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0301', '193', 1, 1, 1, 1, 1, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:50:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0303', '193', 0, 0, 1, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:50:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0306', '193', 1, 1, 0, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:51:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0307', '193', 1, 0, 0, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:49:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0309', '193', 1, 0, 0, 0, 0, 0, to_date('27-04-2013 15:16:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('31-12-2013 09:49:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0100', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0101', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0103', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0104', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0300', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0301', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ecm0302', '196', 0, 0, 0, 0, 0, 0, to_date('28-04-2013 12:03:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 16:59:44', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0000', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0100', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0101', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0102', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0103', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0200', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0201', '3', 0, 0, 0, 0, 0, 0, to_date('10-05-2013 18:49:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 10:20:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0000', '198', 1, 0, 0, 0, 0, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-05-2013 10:10:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0100', '198', 1, 0, 0, 0, 0, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-05-2013 10:10:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0101', '198', 0, 0, 1, 1, 0, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-05-2013 08:45:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0102', '198', 0, 1, 0, 0, 0, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-05-2013 10:10:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0103', '198', 0, 1, 0, 0, 0, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-05-2013 10:10:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0200', '198', 1, 0, 0, 0, 0, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-05-2013 10:10:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('process0201', '198', 1, 1, 1, 0, 1, 0, to_date('15-05-2013 10:10:02', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-05-2013 10:10:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0103', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 11:07:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0202', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 11:08:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0203', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 11:08:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0204', '203', 1, 0, 0, 0, 0, 0, to_date('05-08-2013 11:08:39', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0300', '203', 1, 0, 0, 0, 0, 0, to_date('07-08-2013 11:01:47', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0301', '203', 1, 0, 0, 0, 0, 0, to_date('07-08-2013 11:01:47', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0302', '203', 1, 0, 0, 0, 0, 0, to_date('07-08-2013 11:01:47', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0800', '1', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 17:50:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0803', '1', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 17:50:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0804', '1', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 17:50:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0805', '1', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 17:50:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0806', '1', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 17:50:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0807', '1', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 17:50:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0208', '9', 1, 0, 0, 0, 0, 0, to_date('23-09-2013 13:59:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-09-2013 13:59:35', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0000', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:24:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:10:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0100', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:24:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:10:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0101', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:24:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:10:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0102', '1', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:24:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:10:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0200', '18', 0, 0, 0, 0, 0, 0, to_date('26-09-2013 19:44:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:44:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0200', '2', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 500 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0201', '2', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 18:01:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-09-2013 18:01:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0000', '10', 1, 0, 0, 1, 1, 0, to_date('14-08-2013 09:57:49', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-09-2013 18:47:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0200', '10', 1, 0, 0, 1, 1, 0, to_date('14-08-2013 09:57:49', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-09-2013 18:47:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0201', '10', 1, 0, 0, 1, 0, 0, to_date('14-08-2013 09:57:49', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-09-2013 18:48:13', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0202', '10', 1, 0, 0, 1, 1, 0, to_date('14-08-2013 09:57:49', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-09-2013 18:47:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0300', '10', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:57:49', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:41:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0301', '10', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:57:49', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:41:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0115', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0101', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('bom0103', '195', 0, 0, 0, 0, 0, 0, to_date('17-09-2013 19:05:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:02:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0700', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0701', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0702', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0703', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0704', '1', 0, 0, 0, 0, 0, 0, to_date('04-09-2013 12:46:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0400', '3', 1, 0, 0, 0, 0, 0, to_date('14-10-2013 15:07:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-10-2013 15:35:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0401', '3', 1, 0, 0, 0, 0, 0, to_date('14-10-2013 15:07:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-10-2013 15:35:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0000', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0400', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0440', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0410', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0420', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0100', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0110', '1', 1, 0, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 16:51:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0120', '1', 1, 0, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 16:52:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0200', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0201', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0204', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0209', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0208', '1', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:53:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:53:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0000', '3', 1, 0, 0, 0, 0, 0, to_date('15-08-2013 11:38:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-09-2013 13:40:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0404', '10', 1, 0, 0, 0, 0, 0, to_date('17-10-2013 12:50:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-10-2013 12:50:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('chat0100', '2', 1, 0, 0, 0, 0, 0, to_date('29-10-2013 12:47:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 12:47:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0300', '3', 1, 0, 0, 0, 0, 0, to_date('15-08-2013 11:38:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-09-2013 13:40:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0301', '3', 1, 0, 0, 0, 0, 0, to_date('15-08-2013 11:38:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-09-2013 13:40:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0117', '2', 1, 0, 0, 0, 0, 0, to_date('06-09-2013 15:13:00', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-09-2013 15:13:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0000', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0100', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0103', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0102', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0101', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0104', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0105', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0106', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0200', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0201', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0202', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0203', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0204', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0205', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0300', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0301', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0302', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0400', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0401', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('et0402', '2', 0, 0, 0, 0, 0, 0, to_date('29-10-2013 09:58:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 09:59:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0000', '2', 1, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0300', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0102', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0705', '10', 1, 1, 1, 1, 1, 0, to_date('22-10-2013 16:05:30', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-10-2013 16:41:31', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0303', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0304', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0305', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0302', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0306', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0200', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0101', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0210', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0104', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0205', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0201', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 15:26:44', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0106', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0100', '2', 1, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 600 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0107', '2', 1, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0110', '2', 1, 0, 0, 0, 0, 0, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 13:35:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0117', '1', 0, 0, 0, 0, 0, 0, to_date('05-09-2013 15:59:23', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('22-09-2013 19:21:36', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0402', '10', 1, 0, 0, 0, 0, 0, to_date('26-09-2013 12:49:44', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 12:49:44', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0101', '10', 0, 0, 0, 1, 0, 0, to_date('21-08-2013 15:30:36', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-08-2013 15:31:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0200', '220', 0, 0, 0, 0, 0, 0, to_date('06-11-2013 11:35:30', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:19:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0201', '220', 1, 0, 0, 0, 0, 0, to_date('06-11-2013 11:35:30', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-11-2013 11:35:30', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0202', '220', 1, 0, 1, 0, 0, 0, to_date('06-11-2013 11:35:30', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-11-2013 09:28:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0210', '1', 1, 0, 1, 1, 1, 0, to_date('06-11-2013 15:23:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-11-2013 16:45:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0700', '220', 0, 0, 0, 0, 0, 0, to_date('25-11-2013 11:56:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-11-2013 13:32:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0701', '220', 0, 0, 0, 0, 0, 0, to_date('26-11-2013 13:32:04', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-11-2013 13:32:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0430', '1', 0, 1, 1, 1, 1, 0, to_date('29-11-2013 11:16:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('10-12-2013 10:30:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0203', '220', 1, 0, 1, 1, 1, 0, to_date('04-12-2013 15:05:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-12-2013 09:31:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0205', '220', 0, 0, 0, 0, 0, 0, to_date('09-12-2013 16:11:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:19:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0130', '1', 1, 0, 0, 1, 1, 0, to_date('10-12-2013 15:34:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('11-12-2013 16:16:59', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0117', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0000', '220', 1, 0, 0, 0, 0, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-11-2013 10:52:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0100', '220', 1, 0, 0, 0, 0, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-11-2013 10:52:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0101', '220', 1, 0, 1, 1, 1, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-11-2013 14:42:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0102', '220', 1, 0, 0, 0, 0, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:18:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0103', '220', 0, 0, 0, 0, 0, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:18:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0104', '220', 1, 0, 0, 0, 0, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-11-2013 10:52:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0105', '220', 1, 0, 0, 0, 0, 0, to_date('05-11-2013 10:52:56', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-11-2013 10:52:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '203', 1, 0, 0, 0, 0, 0, to_date('16-12-2013 09:16:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-12-2013 09:17:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0200', '3', 1, 0, 0, 0, 0, 0, to_date('18-12-2013 15:48:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-12-2013 15:48:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0201', '3', 1, 0, 0, 0, 0, 0, to_date('18-12-2013 15:57:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-12-2013 15:57:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0202', '3', 1, 0, 0, 0, 0, 0, to_date('18-12-2013 15:57:28', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-12-2013 15:57:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0000', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0100', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0101', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0200', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0201', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0202', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0300', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0301', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0303', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0306', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0307', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mat0309', '220', 0, 0, 0, 0, 0, 0, to_date('22-11-2013 10:24:03', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:50:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '5', 0, 0, 0, 0, 0, 0, null, null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0000', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0100', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0107', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0110', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('29-09-2013 17:17:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:20:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0000', '4', 1, 0, 1, 0, 0, 0, to_date('05-09-2012 10:31:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('05-09-2012 10:31:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0100', '4', 1, 0, 1, 0, 0, 0, to_date('05-09-2012 10:31:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-09-2012 11:49:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0101', '4', 1, 1, 1, 0, 1, 0, to_date('05-09-2012 10:31:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('07-09-2012 15:33:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0102', '4', 1, 1, 1, 0, 1, 0, to_date('05-09-2012 10:31:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('10-09-2012 17:03:54', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
commit;
prompt 700 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '8', 0, 0, 0, 0, 0, 0, null, null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0000', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0100', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0107', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0110', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0200', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0201', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-08-2012 17:03:04', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0802', '1', 0, 0, 0, 0, 0, 0, to_date('16-09-2013 17:45:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('chat0000', '2', 1, 0, 0, 0, 0, 0, to_date('29-10-2013 12:12:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 12:47:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('06-07-2012 10:30:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('05-07-2012 14:36:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0000', '9', 1, 1, 1, 0, 1, 0, null, null, to_date('06-07-2012 10:30:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0100', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-09-2013 18:01:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0101', '9', 0, 0, 0, 0, 0, 0, null, null, to_date('16-09-2013 18:01:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0200', '9', 1, 1, 1, 0, 1, 0, null, null, to_date('06-07-2012 10:30:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0201', '9', 1, 1, 1, 0, 1, 0, null, null, to_date('06-07-2012 10:30:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0203', '9', 0, 0, 1, 1, 1, 0, null, null, to_date('10-08-2012 19:14:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0204', '9', 1, 1, 0, 0, 0, 0, null, null, to_date('27-09-2013 15:54:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0206', '9', 0, 1, 0, 0, 0, 0, null, null, to_date('16-08-2012 16:05:59', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '2', 0, 1, 1, 1, 1, 0, to_date('20-06-2012 16:51:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-09-2013 15:11:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '2', 1, 0, 0, 0, 0, 0, to_date('20-06-2012 16:51:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:14:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '2', 1, 0, 0, 0, 0, 0, to_date('20-06-2012 16:51:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('23-09-2013 09:08:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '2', 1, 0, 0, 0, 1, 0, to_date('20-06-2012 16:51:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '2', 0, 0, 0, 0, 0, 0, to_date('20-06-2012 16:51:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-04-2013 09:31:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '2', 0, 0, 0, 0, 0, 0, to_date('20-06-2012 16:51:34', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-04-2013 09:31:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '18', 0, 0, 0, 0, 0, 0, to_date('20-06-2012 17:35:48', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0402', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0800', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0802', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0810', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0803', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0804', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0805', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0806', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0807', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0700', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0701', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0702', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0703', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0704', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0302', '3', 1, 0, 0, 0, 0, 0, to_date('14-10-2013 12:45:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-10-2013 12:45:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:02:42', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0402', '3', 1, 0, 0, 0, 0, 0, to_date('15-10-2013 11:41:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2013 11:41:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
commit;
prompt 800 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:37:07', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0000', '173', 1, 0, 0, 0, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0100', '173', 1, 0, 0, 0, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0101', '173', 1, 0, 1, 1, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-04-2014 14:54:31', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0102', '173', 0, 0, 0, 0, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('12-03-2013 09:45:31', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0103', '173', 0, 1, 0, 0, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('12-03-2013 09:45:00', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0104', '173', 0, 0, 0, 0, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('12-03-2013 09:44:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0501', '173', 1, 1, 0, 0, 0, 0, to_date('12-03-2013 09:44:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-03-2013 10:17:26', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:01:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('chat0101', '2', 1, 0, 0, 0, 0, 0, to_date('29-10-2013 12:46:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-10-2013 12:47:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '3', 0, 0, 0, 0, 0, 0, to_date('08-10-2012 16:03:58', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-08-2013 11:44:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0000', '9', 0, 0, 0, 0, 0, 0, to_date('14-10-2013 15:04:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0300', '9', 0, 0, 0, 0, 0, 0, to_date('14-10-2013 15:04:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0301', '9', 0, 0, 0, 0, 0, 0, to_date('14-10-2013 15:04:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0302', '9', 0, 0, 0, 0, 0, 0, to_date('14-10-2013 15:04:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0400', '9', 0, 0, 0, 0, 0, 0, to_date('14-10-2013 15:04:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0401', '9', 0, 0, 0, 0, 0, 0, to_date('14-10-2013 15:04:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0000', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0200', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0201', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0202', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0200', '4', 1, 0, 1, 0, 0, 0, to_date('05-09-2012 10:31:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('11-09-2012 15:03:08', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0300', '4', 1, 0, 1, 0, 0, 0, to_date('05-09-2012 10:31:45', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('06-09-2012 11:49:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0300', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0301', '3', 0, 0, 0, 0, 0, 0, to_date('15-08-2013 11:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0000', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0100', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0104', '10', 0, 0, 0, 0, 0, 0, to_date('29-08-2011 09:54:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0107', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0110', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('30-08-2012 17:27:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '10', 0, 1, 1, 1, 1, 0, null, null, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '10', 0, 1, 1, 1, 1, 0, null, null, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('28-08-2012 18:30:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '10', 0, 1, 1, 0, 1, 0, null, null, to_date('27-08-2012 15:10:48', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '10', 0, 0, 1, 1, 1, 0, null, null, to_date('05-07-2012 14:34:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '10', 0, 1, 1, 1, 1, 0, null, null, to_date('02-01-2014 15:38:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:42:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '10', 0, 1, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:46:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:42:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('23-08-2013 15:02:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('23-08-2013 15:02:36', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:42:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:42:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '10', 1, 1, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:42:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:21:08', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '10', 0, 1, 0, 0, 0, 0, null, null, to_date('26-09-2013 15:41:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '10', 1, 0, 0, 0, 1, 0, null, null, to_date('26-09-2013 16:07:51', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('30-08-2012 16:41:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('15-08-2013 09:22:37', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '10', 1, 0, 0, 0, 0, 0, null, null, to_date('23-12-2013 16:57:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('pa0000', '10', 0, 0, 0, 0, 0, 0, null, null, to_date('18-01-2013 15:41:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0000', '11', 1, 0, 1, 1, 1, 0, null, null, null, null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0104', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '174', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:12:48', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), '25258457', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:06:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0000', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0100', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0101', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0102', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0000', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0100', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0101', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0107', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 900 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0109', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0700', '10', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:57:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0102', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0103', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0000', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0216', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0430', '2', 0, 0, 0, 0, 0, 0, to_date('21-04-2014 10:22:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0450', '2', 0, 0, 0, 0, 0, 0, to_date('21-04-2014 10:22:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0210', '2', 0, 0, 0, 0, 0, 0, to_date('21-04-2014 10:22:46', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0460', '1', 1, 0, 0, 0, 0, 0, to_date('29-04-2014 12:02:24', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-04-2014 12:02:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0200', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0201', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0202', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0203', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0204', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0300', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0701', '10', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:57:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0400', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0440', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0410', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0420', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0100', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0110', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('07-03-2013 14:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '173', 0, 0, 0, 0, 0, 0, to_date('07-03-2013 14:36:35', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('07-03-2013 14:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0120', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0200', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0201', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '5', 0, 0, 0, 0, 0, 0, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-06-2012 11:24:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0000', '5', 1, 0, 0, 0, 0, 0, to_date('25-06-2012 11:25:24', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:37:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0301', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0116', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:10:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0200', '18', 0, 1, 1, 1, 1, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 18:31:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0202', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0211', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0302', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0900', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0201', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0210', '18', 0, 1, 1, 1, 1, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 18:31:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0610', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0612', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:12:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0204', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0209', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0400', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:13:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:13:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0208', '2', 0, 0, 0, 0, 0, 0, to_date('14-08-2013 09:44:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0702', '10', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:57:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0703', '10', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:57:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0704', '10', 1, 1, 1, 1, 1, 0, to_date('14-08-2013 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('14-08-2013 09:57:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0901', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0205', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:13:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0206', '18', 0, 0, 0, 0, 0, 0, to_date('15-10-2012 18:10:10', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('15-10-2012 18:13:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0602', '2', 1, 0, 0, 0, 1, 0, to_date('25-10-2012 19:33:31', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0902', '4', 0, 0, 0, 0, 0, 0, to_date('16-08-2013 16:14:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('16-08-2013 16:14:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '3', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:13:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ar0114', '2', 1, 0, 0, 0, 0, 0, to_date('25-09-2013 09:21:16', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('25-09-2013 09:21:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0203', '18', 0, 0, 0, 0, 0, 0, to_date('26-09-2013 18:31:22', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('26-09-2013 19:45:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('eva0202', '4', 1, 0, 0, 0, 0, 0, to_date('29-09-2013 15:54:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-09-2013 15:54:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0115', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('fico0102', '203', 1, 0, 0, 0, 0, 0, to_date('13-12-2013 16:53:20', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('13-12-2013 18:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0101', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0111', '174', 1, 0, 0, 0, 0, 0, to_date('27-02-2014 14:16:17', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-02-2014 14:16:17', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 1000 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0401', '2', 0, 1, 0, 0, 0, 0, null, null, to_date('29-09-2013 14:15:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0600', '2', 1, 0, 0, 0, 1, 0, null, null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0606', '2', 1, 0, 0, 0, 1, 0, null, null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0607', '2', 1, 0, 0, 0, 1, 0, null, null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0608', '2', 1, 0, 0, 0, 1, 0, null, null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0613', '2', 1, 0, 0, 0, 1, 0, null, null, to_date('25-09-2013 12:34:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '3', 0, 0, 0, 0, 0, 0, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0450', '1', 1, 0, 0, 0, 0, 0, to_date('24-12-2013 16:36:06', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:36:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0117', '173', 0, 0, 0, 0, 0, 0, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-12-2013 16:49:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0203', '173', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 16:59:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0205', '173', 1, 0, 1, 0, 1, 0, to_date('27-12-2013 16:58:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:38:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '11', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:15:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0116', '1', 0, 0, 0, 0, 0, 0, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0502', '1', 0, 0, 0, 0, 0, 0, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0402', '1', 0, 0, 0, 0, 0, 0, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0404', '1', 0, 0, 0, 0, 0, 0, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0705', '1', 0, 0, 0, 0, 0, 0, to_date('28-01-2014 14:07:15', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:07:40', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('sy0211', '1', 0, 1, 1, 1, 1, 0, to_date('28-01-2014 14:16:01', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('28-01-2014 14:16:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0000', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0100', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:49', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0115', '558', 1, 0, 0, 0, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0101', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0102', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:10', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0114', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:13', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0107', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:15', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0109', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0112', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:29:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0116', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:53', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0200', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0201', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0202', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:30', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0205', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0206', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:38', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0500', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0502', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0501', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0507', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0506', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0503', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0504', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0505', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:28:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0300', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0302', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0303', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0400', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0403', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0402', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0404', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:54', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0800', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0802', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0810', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0803', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0804', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0805', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0806', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0807', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:26:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0700', '558', 1, 1, 1, 1, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0701', '558', 1, 1, 1, 1, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0702', '558', 1, 1, 1, 1, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0703', '558', 1, 1, 1, 1, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0704', '558', 1, 1, 1, 1, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0705', '558', 1, 1, 1, 1, 1, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0600', '558', 1, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0602', '558', 1, 0, 0, 1, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0601', '558', 0, 0, 0, 0, 0, 0, to_date('29-01-2014 10:25:05', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('29-01-2014 10:33:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0000', '1001', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mobile0000', '1000', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0100', '1001', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0101', '1001', 1, 0, 0, 0, 1, 0, to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 11:55:07', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mobile0100', '1000', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('message0102', '1001', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 11:54:55', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mobile0101', '1000', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mobile0102', '1000', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mobile0200', '1000', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('mobile0201', '1000', 1, 0, 1, 1, 1, 0, to_date('17-02-2014 11:53:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:53:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0200', '5', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:37:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:37:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0201', '5', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:37:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:37:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0202', '5', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:37:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:37:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0300', '5', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 10:37:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:37:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('as0301', '5', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 10:37:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:37:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0700', '171', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 10:51:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0701', '171', 1, 1, 1, 1, 1, 0, to_date('17-02-2014 10:51:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('18-02-2014 14:12:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0702', '171', 1, 1, 1, 1, 1, 0, to_date('17-02-2014 10:51:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:54:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0000', '171', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 10:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0100', '171', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:51:54', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0101', '171', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:51:54', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0501', '171', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:51:52', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:51:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0900', '10', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 14:01:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:01:29', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0901', '10', 1, 0, 1, 1, 1, 0, to_date('17-02-2014 14:01:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:01:36', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0000', '174', 1, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0100', '174', 1, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 1100 records committed...
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0101', '174', 0, 0, 0, 0, 0, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 11:15:47', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0102', '174', 1, 0, 1, 1, 1, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:24:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0103', '174', 1, 0, 1, 1, 1, 0, to_date('27-12-2013 17:21:37', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:24:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0502', '10', 1, 0, 0, 0, 0, 0, to_date('24-02-2014 12:11:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-02-2014 12:11:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0000', '1002', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0000', '10', 1, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0100', '10', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0100', '1002', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0101', '10', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0116', '3', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0502', '3', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0404', '3', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0705', '3', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0402', '9', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0200', '9', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0201', '9', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('report0202', '9', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0501', '10', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:57', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0700', '10', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:59', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0701', '10', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:59', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('cust0702', '10', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 13:57:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 13:57:59', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0101', '1002', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0102', '1002', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0103', '1002', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0104', '1002', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0105', '1002', 0, 0, 0, 0, 0, 0, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0200', '1002', 0, 0, 0, 0, 0, 1, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('prosto0205', '1002', 0, 0, 0, 0, 0, 1, to_date('17-02-2014 14:41:09', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('17-02-2014 14:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0213', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('ess0204', '10', 0, 0, 0, 0, 0, 0, to_date('27-08-2012 15:49:57', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('27-08-2012 15:50:03', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0209', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0208', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
insert into SY_SCREEN_GRANT (screen_code, screen_grant_id, selectr, saver, insertr, updater, deleter, cancelr, create_date, created_by, update_date, updated_by, orderno, activity)
values ('hr0204', '8', 0, 0, 0, 0, 0, 0, to_date('30-09-2013 15:36:53', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2013 15:36:58', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1);
commit;
prompt 1133 records loaded
prompt Enabling foreign key constraints for SY_SCREEN_GRANT...
alter table SY_SCREEN_GRANT enable constraint FK_SY_SCREEN_GRANT;
prompt Enabling triggers for SY_SCREEN_GRANT...
alter table SY_SCREEN_GRANT enable all triggers;
set feedback on
set define on
prompt Done.
exit;