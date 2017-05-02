#!/bin/bash

echo "Iniciando setup-database"
USER_NAME=postgres
DB_USER=admin
DB_PASS=Op3nd4t4

TEST=`psql --username postgres <<- EOSQL
   SELECT 1 FROM pg_database WHERE datname='$DB_NAME';
EOSQL`


echo "******CREATING DOCKER DATABASE******"
if [[ $TEST == "1" ]]; then
    # database exists
    # $? is 0
    exit 0
else
psql --username $USER_NAME <<- EOSQL
   CREATE ROLE $DB_USER WITH LOGIN ENCRYPTED PASSWORD '${DB_PASS}' CREATEDB;
EOSQL

psql --username $USER_NAME <<- EOSQL
   CREATE ROLE $USER_NAME WITH LOGIN ENCRYPTED PASSWORD '${DB_PASS}' CREATEDB;
EOSQL

psql --username $USER_NAME <<- EOSQL
   CREATE DATABASE $DB_NAME WITH OWNER $DB_USER TEMPLATE template0 ENCODING 'UTF8';
EOSQL

psql --username $USER_NAME <<- EOSQL
   GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOSQL

psql --username $USER_NAME $DB_NAME<<- EOSQL
   CREATE EXTENSION UNACCENT;
EOSQL

psql --username $USER_NAME $DB_NAME<<- EOSQL
   CREATE EXTENSION postgis;
EOSQL
fi

echo ""
echo "******DOCKER DATABASE CREATED******"
