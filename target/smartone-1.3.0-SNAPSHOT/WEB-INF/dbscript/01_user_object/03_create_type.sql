---------------------------------------------
-- Export file for user WINE               --
-- Created by Yayoi on 2014/1/26, 16:59:43 --
---------------------------------------------

set define off
spool type.log

prompt
prompt Creating type TYPE_SPLIT
prompt ========================
prompt
CREATE OR REPLACE TYPE "TYPE_SPLIT" IS TABLE OF VARCHAR2 (4000)
/


spool off
exit;