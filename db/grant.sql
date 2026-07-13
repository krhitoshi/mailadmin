-- Grant the app user privileges to create the test DB (mailadmin_test)
GRANT ALL PRIVILEGES ON `mailadmin\_%`.* TO 'mailadmin'@'%';
FLUSH PRIVILEGES;
