MYSQL_PWD=password mysql -hlocalhost --protocol=tcp -ujohn -Ddb --ssl-mode=VERIFY_IDENTITY --ssl-ca=$PWD/../../certs/ca_server.crt --ssl-cert=$PWD/../../certs/client.crt --ssl-key=$PWD/../../certs/client.key