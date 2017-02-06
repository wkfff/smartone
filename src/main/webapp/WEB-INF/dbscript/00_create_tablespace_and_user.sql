CREATE TABLESPACE SPERP DATAFILE 'SPERP.DBF' SIZE 500M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED LOGGING EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO;
COMMIT;

CREATE USER SPERP IDENTIFIED BY SPERP DEFAULT TABLESPACE SPERP;
COMMIT;

ALTER USER SPERP QUOTA UNLIMITED ON SPERP;
GRANT DBA TO SPERP;
GRANT RESOURCE TO SPERP;
GRANT EXP_FULL_DATABASE TO SPERP;
GRANT IMP_FULL_DATABASE TO SPERP;
GRANT CONNECT TO SPERP;
COMMIT;
exit;