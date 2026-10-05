import psycopg2
from psycopg2.extras import RealDictCursor

DB_CONFIG = {
    "dbname": "Loja_Roupas",
    "user": "postgres",
    "password": "1230",
    "host": "localhost",
    "port": "5432"
}

def get_db_connection():
    conn = psycopg2.connect(**DB_CONFIG)
    return conn