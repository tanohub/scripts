#!/usr/bin/python3
import os
import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(host='localhost',
                                         database='DB01',
                                         user='root',
                                         password='Password123')
    sql_select_Query = "select * from db01tab0111"
    # MySQLCursorDict creates a cursor that returns rows as dictionaries
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql_select_Query)
    records = cursor.fetchall()
   
    print("Fetching each row using column name")
    for row in records:
        id = row["id"]
        user = row["user"]
        domain = row["domain"]
        region = row["region"]
        print("| ", id, " | ", user," | ", domain, "\t | ", region, " |")

    entry = 0  
    print("Fetching specific dictionary entry\\row, with id", entry)
    row = records[entry]
    id = row["id"]
    user = row["user"]
    domain = row["domain"]
    region = row["region"]
    print("| ", id, " | ", user," | ", domain, "\t | ", region, " |")

except Error as e:
    print("Error reading data from MySQL table ! \nError message :", e)
finally:
    if connection.is_connected():
        connection.close()
        cursor.close()
        print("MySQL connection is closed")
