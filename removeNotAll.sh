#!/bin/bash
#
# This script retains 3 files
# Created by Burnz Barbosa
#
#
LOG_FILE="/var/log/retain_script.log"
cd /home/backup/
num_files=`ls | wc -l`
rm `ls -tp | grep -v "/$" | awk '{ if (NR > 3) print; }'`
num_files2=`ls | wc -l`
/bin/echo "[$(date)]You have the latest $num_files2 retained in backup files " >> $LOG_FILE

# Script Explanations:
# The script is to keep the latest 2 files under /mnt/backups/full
# 1. We declare the log file at /var/log/ named as retain_script.log
# 2. Go to the backup directory, lets assumed /mnt/backups/full
# 3. Then we remove the count of oldest files and retain the latest 2
# 4. We ask to display the counts or number of files that it contains
# 5. We write a log with a date telling how many backups have retained and put it in the logfile
