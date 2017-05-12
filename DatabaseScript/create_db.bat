echo off
sqlcmd -S localhost -E -i GameDataBase.sql

ECHO if no message appear DB was created
PAUSE