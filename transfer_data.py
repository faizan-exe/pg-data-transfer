import psycopg2
import subprocess

# Database connection parameters
source_db_config = {
    "dbname": "providerdatasets5",
    "user": "providerdatasets5",
    "password": "chandrabhan",
    "host": "35.202.191.18"
}

destination_db_config = {
    "dbname": "d2rt9pkv87jent",
    "user": "icytkdvjfmhqxe",
    "password": "512e8a19c62c96b0054b5fadc536e0ad5ba7036b1a3c4f65ebe9fb2158272a74",
    "host": "ec2-18-211-215-8.compute-1.amazonaws.com",
    "port": "5432"
}

# Connect to the source database and list all tables from both public and doctors schemas
def list_tables(conn):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT table_schema, table_name
            FROM information_schema.tables
            WHERE table_schema IN ('public', 'doctors')
        """)
        return [(table[0], table[1]) for table in cur.fetchall()]  # Returns a list of tuples (schema_name, table_name)

# Export 1000 rows from each table
def export_data(conn, schema_name, table_name):
    with conn.cursor() as cur:
        query = f"COPY (SELECT * FROM {schema_name}.{table_name} LIMIT 1000) TO STDOUT WITH CSV HEADER"
        with open(f"{schema_name}_{table_name}.csv", "w",  encoding='utf-8') as file:  # Naming files with schema_name for uniqueness
            cur.copy_expert(query, file)

# Import data into the destination database
def import_data(schema_name, table_name, conn):
    try:
        with conn.cursor() as cur:
            # Attempt to TRUNCATE the table; this will fail if the table doesn't exist
            cur.execute(f"TRUNCATE {schema_name}.{table_name} RESTART IDENTITY")
            conn.commit()  # Commit the TRUNCATE operation
            
            # Prepare the COPY command to import data from a CSV file
            query = f"COPY {schema_name}.{table_name} FROM STDIN WITH CSV HEADER"
            csv_file_path = f"{schema_name}_{table_name}.csv"
            with open(csv_file_path, "r", encoding='utf-8') as file:
                # Attempt to COPY the data; this will also fail if the table doesn't exist
                cur.copy_expert(query, file)
            conn.commit()  # Commit the COPY operation
            print(f"Data imported successfully for {schema_name}.{table_name}")
    except psycopg2.errors.UndefinedTable:
        # Handle the case where the table does not exist
        print(f"Table {schema_name}.{table_name} does not exist. Skipping import.")
    except Exception as e:
        # General exception handling to catch other errors
        print(f"An error occurred while importing data for {schema_name}.{table_name}: {e}")

        
if __name__ == "__main__":
    # Connect to source database
    source_conn = psycopg2.connect(**source_db_config)
    tables = list_tables(source_conn)

    for schema_name, table_name in tables:
        print(f"Exporting data for table: {schema_name}.{table_name}")
        export_data(source_conn, schema_name, table_name)
    source_conn.close()

    # Connect to destination database
    destination_conn = psycopg2.connect(**destination_db_config)
    destination_conn.autocommit = True  # To execute TRUNCATE without transaction block

    for schema_name, table_name in tables:
        print(f"Importing data for table: {schema_name}.{table_name}")
        import_data(schema_name, table_name, destination_conn)
    destination_conn.close()

    print("Data migration completed.")
