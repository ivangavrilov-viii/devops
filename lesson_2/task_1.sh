#!/usr/bin/bash

# DIRECTORY FOR FILE CREATION ON FIRST MACHINE
SAVE_DIR="/Users/ivan/ivan_dev/devops/lesson_2/"

# CREATION FILES
for i in {1..5};
    do
        echo "Some content in $i file" >> file_$i.txt;
    done


