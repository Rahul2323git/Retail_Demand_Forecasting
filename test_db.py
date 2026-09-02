from src.db_config.database import get_connection

try:
    conn = get_connection()

    cursor = conn.cursor()
    cursor.execute("SELECT DB_NAME()")

    result = cursor.fetchone()

    print("Connected successfully!")
    print("Database:", result[0])

    conn.close()

except Exception as e:
    print("Database connection failed!")
    print(e)