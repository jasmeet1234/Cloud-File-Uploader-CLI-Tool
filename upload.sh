#!/bin/bash

# useage function to guide users for correct format
useage(){
    echo "Format: $0 File_Path Directory_Name"
    echo "Example: $0 myFile.txt {/user/folder/}"
    exit 1
}

# To check whether cli is installed or not
if ! which aws &> /dev/null; then
    echo "aws cli is not installed, Please install and configure it to continue"
fi

# To provide users with useage info
if [[ -z "$1" ]]; then
    useage
fi

FILENAME="$1"
DIRECTORY="$2"

# To check whether file exists or not
if [ ! -f "$FILENAME" ]; then
    echo "$FILENAME does not exists"
fi

# To guide user to add Path of their Bucket
if ! grep -q 'export AWSBUCKET=' ~/.bashrc; then
    echo "Your bucket name is not defined in environment variable"
    echo "Please enter your bucket name:"
    read -r AWSBUCKET
    echo "export AWSBUCKET=\"$AWSBUCKET\"" >> ~/.bashrc
    source ~/.bashrc
fi

# Setting Target Path
if [ -z "$DIRECTORY" ]; then
    TARGET_PATH="s3://$AWSBUCKET/$(basename "$FILENAME")"
else
    TARGET_PATH="s3://$AWSBUCKET$DIRECTORY$(basename "$FILENAME")"
fi

echo "Uploading $FILENAME to $TARGET_PATH..."

# Upload the file to S3 with progress indication
pv "$FILENAME" | aws s3 cp - "$TARGET_PATH"

# Checking success of the operation 
if [ "$?" -eq 0 ]; then 
    echo "$FILENAME" is successfully uploaded

    # Generate a shareable link
    SHAREABLE_LINK=$(aws s3 presign "$TARGET_PATH" --expires-in 3600)
    echo "Shareable link (valid for 1 hour): $SHAREABLE_LINK"
else
    echo Error uploading File
fi






