sql2json
========

This script takes a SQL file and create the input files for android-contentprovider-generator 
(https://github.com/BoD/android-contentprovider-generator) 

Example:
========

Given the following SQL create clause:

CREATE TABLE COMPANY
(
ID INT PRIMARY KEY     NOT NULL,
NAME           TEXT    NOT NULL,
AGE            INT     NOT NULL,
ADDRESS        CHAR(50)
);

The script will generate the following json file:

{
    "fields": [
    {
        "name": "ID",
        "type": "Int",
        "nullable": false,
    },
    {
        "name": "NAME",
        "type": "String",
        "nullable": false,
    },
    {
        "name": "AGE",
        "type": "Int",
        "nullable": false,
    },
    {
        "name": "ADDRESS",
        "type": "Char",
    },
    ]
}

