UPDATE mysql.user SET Password=PASSWORD('111') WHERE User='root';

DELETE FROM mysql.user WHERE User='';

DROP USER ''@'%';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

DROP DATABASE test;

FLUSH PRIVILEGES;