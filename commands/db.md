# find all disks - both default and external
lsblk

#check if a fs exists

sudo file -s /dev/nvme1n1

#mountpoint
sudo mkdir -p /data

#mount the ebs to /data

sudo mount /dev/nvme1n1 /data

#----------------------------------------------------#

#Check postgres default data directory/default disk

sudo -u postgres psql -c "SHOW data_directory;"

#stop and check
sudo systemctl stop postgresql@14-main
sudo pg_lsclusters

#Modify the default data directory of psql to EBS
sudo pg_conftool 14 main set data_directory /data/main

sudo pg_conftool 14 main show data_directory

sudo systemctl start postgresql@14-main

sudo -u postgres psql -c "SHOW data_directory;"


#---------------------------------------------------------#

sudo -u postgres psql

#show all dbs

SELECT datname FROM pg_database;

#show schemas
SELECT schema_name
FROM information_schema.schemata;

#users

SELECT usename FROM pg_user;

SELECT current_database();


#Show tables

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
ORDER BY table_schema, table_name;

#Show columns of a table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'your_table';

#query data
SELECT * FROM your_table;
SELECT * FROM your_table LIMIT 10;

#switch DB

\c mfdb

#psql specific commands
\l
\c
\dt
\d
\du
\q
