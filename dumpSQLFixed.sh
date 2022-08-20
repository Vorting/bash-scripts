#!/bin/bash

# Create dump of MySQL table

# DB_NAME
DBNAME='menagerie'

# DB_USER
DBUSER='dimaAdmin'

# MySQL database
TABLENAME='menagerie'

# MySQL database password
DBPASSWORD='dima5357'

# SQL hostname
DBHOST='localhost'

# Current date
DATE=`date +"%Y%m%d-%H%M"`

# Working directory
CURRDIR="/home/backup"

# File to store dump
FILEDUMP="${CURRDIR}/${DBNAME}-${DATE}.sql"

echo "creating dump ${DBNAME} in ${FILEDUMP}"
mysqldump -u${DBUSER} -p${DBPASSWORD} -h${DBHOST} ${DBNAME} > ${FILEDUMP}

# uncomment this line to do backup for PostgresSQL
# pg_dump -U${DBUSER} -h${DBHOST} ${DBNAME} > ${FILEDUMP} 


# Create zip archive
ARCNAME="backup-$DBNAME-$DATE.zip"
echo "creating zip archive $ARCNAME"
cd $CURRDIR
zip -r ${ARCNAME} $FILEDUMP
