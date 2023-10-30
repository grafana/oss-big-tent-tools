set -e
openssl req -new -nodes -text -out certs/ca_server.csr -keyout certs/ca_server.key -subj "/CN=ca_server"
openssl x509 -req -in certs/ca_server.csr -text -days 3650 -extfile /opt/homebrew/etc/openssl@3/openssl.cnf -extensions v3_ca -signkey certs/ca_server.key -out certs/ca_server.crt

# the server-cert's `subject` and alt-name needs to have the correct value
openssl req -new -nodes -text -out certs/server.csr -keyout certs/server.key -subj "/CN=localhost" -addext "subjectAltName = DNS:localhost"
openssl x509 -req -in certs/server.csr -text -days 365 -CA certs/ca_server.crt -CAkey certs/ca_server.key -CAcreateserial -copy_extensions copy -ext subjectAltName -out certs/server.crt

openssl req -new -nodes -text -out certs/ca_client.csr -keyout certs/ca_client.key -subj "/CN=ca_client"
openssl x509 -req -in certs/ca_client.csr -text -days 3650 -extfile /opt/homebrew/etc/openssl@3/openssl.cnf -extensions v3_ca -signkey certs/ca_client.key -out certs/ca_client.crt

# the client-cert's `subject` must refer to the postgres user-name
openssl req -new -nodes -text -out certs/client.csr -keyout certs/client.key -subj "/CN=john"
openssl x509 -req -in certs/client.csr -text -days 365 -CA certs/ca_client.crt -CAkey certs/ca_client.key -CAcreateserial -out certs/client.crt
