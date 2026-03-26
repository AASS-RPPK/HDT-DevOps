#!/bin/bash
# Creates a separate database for each microservice.
# Mounted into the postgres container via docker-entrypoint-initdb.d.

set -e
set -u

create_database() {
    local database=$1
    echo "Creating database '$database' ..."
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
        CREATE DATABASE "$database";
        GRANT ALL PRIVILEGES ON DATABASE "$database" TO "$POSTGRES_USER";
EOSQL
}

create_database "hdt_image_processing"
create_database "hdt_ai_prediction"
create_database "hdt_ai_agent"
create_database "hdt_behavioral_monitoring"
create_database "hdt_identity_provider"

echo "All databases created successfully."
