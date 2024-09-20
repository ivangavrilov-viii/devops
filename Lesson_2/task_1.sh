#!/bin/bash

LOCAL_DIR="path_to_dir"
FILE_NUM=1

REMOTE_DIR="path_to_dir"
REMOTE_IP="ip"
REMOTE_USER="user"

for i in $(seq 1 $FILE_NUM); do
    FILEPATH="$LOCAL_DIR/file_$i.txt"
    base64 /dev/urandom | head -c 1024 > $FILEPATH;
    rsync -avz "file_$i.txt" $REMOTE_USER@$REMOTE_IP:$REMOTE_DIR

    if [ $? -eq 0 ]; then
        rm $FILEPATH
    else
        echo "Error"
    fi
done

DELETE_CMD="find $REMOTE_DIR -type f -mtime +7 -exec rm {} \;"
ssh $REMOTE_USER@$REMOTE_IP "$DELETE_CMD"

if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Error"
fi

# crontab -e
# 0 0 * * * /path_to_file/task_1.sh
