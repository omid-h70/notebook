#!/bin/bash

# Start SQL Server in the background with no log
#/opt/mssql/bin/sqlservr &> /dev/null &

/opt/mssql/bin/sqlservr &

# Wait for MSSQL to start accepting connections
echo "Waiting for SQL Server to be ready..."
#until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N -Q "SELECT 1" &> /dev/null
until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N o -Q "SELECT 1"
do
    sleep 1
done

echo "SQL Server is ready!"

# Run all SQL scripts
SQL_QUERY="
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '$MSSQL_DB_NAME')
BEGIN
    CREATE DATABASE [$MSSQL_DB_NAME];
END
ELSE
BEGIN
    PRINT N'Database [$MSSQL_DB_NAME] already exists. Skipping creation.';
END
"


# Run all SQL scripts
#SQL_QUERY=$(cat <<EOF
#IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '$MSSQL_DB_NAME')
#BEGIN
#    CREATE DATABASE [$MSSQL_DB_NAME];
#END
#ELSE
#BEGIN
#    PRINT N'Database [$MSSQL_DB_NAME] already exists. Skipping creation.';
#END
#EOF
#)

#echo "$SQL_QUERY"

echo "Running ..."
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N o -Q "$SQL_QUERY"

wait
