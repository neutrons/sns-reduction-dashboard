#!/bin/bash
set -e

# DATABASE_URL=psql://USER:PASSWORD@DOMAIN:PORT/DATABASE
user_password=${DATABASE_URL#psql://}
user_password=${user_password%@*}
user=${user_password%:*}
password=${user_password#*:}
database=${DATABASE_URL##*/}

if [ -z "$password" ]; then
    echo "Error: \$password not found" >&2
    exit 1
fi

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
CREATE USER $user WITH UNENCRYPTED PASSWORD '$password';
CREATE DATABASE $database;
GRANT ALL PRIVILEGES ON DATABASE $database TO $user;
EOSQL
