-- test DB (mailadmin_test) の作成権限をアプリユーザに与える
GRANT ALL PRIVILEGES ON `mailadmin\_%`.* TO 'mailadmin'@'%';
FLUSH PRIVILEGES;
