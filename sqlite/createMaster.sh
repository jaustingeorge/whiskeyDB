#! /bin/bash

# This script adds together all of the SQL files needed to rebuild the whiskey 
# database in to the masterWhiskey.sql file to be ran using the .read command 
# in SQLite3.

rm masterWhiskey.sql
cat dropTablesWhiskey.sql >> masterWhiskey.sql
cat tablesWhiskey.sql >> masterWhiskey.sql
cat distillerInsert.sql >> masterWhiskey.sql
cat bottlerInsert.sql >> masterWhiskey.sql
cat bottleInsert.sql >> masterWhiskey.sql
cat purchaseInsert.sql >> masterWhiskey.sql
