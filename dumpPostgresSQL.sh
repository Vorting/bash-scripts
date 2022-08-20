#!/bin/bash

# Create dump of MySQL table

# DB_NAME
DBNAME='thingsboard'

# DB_USER
DBUSER='postgres'

# MySQL database
TABLENAME='thingsboard'

# MySQL database password
PGPASSWORD='dima5357'

# SQL hostname
DBHOST='localhost'

# Current date
DATE=`date +"%Y%m%d-%H%M"`

# Working directory
CURRDIR="/home/dmytro"

# File to store dump
FILEDUMP="${CURRDIR}/${DBNAME}-${DATE}.sql"

echo "creating dump ${DBNAME} in ${FILEDUMP}"

pg_dump -U${DBUSER} -h${DBHOST} ${DBNAME} > ${FILEDUMP}

# Create zip archive
ARCNAME="backup-$DBNAME-$DATE.zip"
echo "creating zip archive $ARCNAME"
cd $CURRDIR
zip -r ${ARCNAME} $FILEDUMP
