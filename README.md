sql2json
========

This script takes a SQL file and create the input files for android-contentprovider-generator 
(https://github.com/BoD/android-contentprovider-generator) 

Example:
========

Given the following SQL create clause:

<pre>
CREATE TABLE COMPANY
(
ID INT PRIMARY KEY     NOT NULL,
NAME           TEXT    NOT NULL,
AGE            INT     NOT NULL,
ADDRESS        CHAR(50)
);
</pre>

The script will generate the following json file:

<pre>
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
</pre>

Usage:
========
<pre>
perl sql2json.pl <sql_file>
</pre>
