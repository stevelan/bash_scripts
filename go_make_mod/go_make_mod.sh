#!/bin/bash
# Initialises a new go module with archetypal makefile, skeleton README, and $1.go with main function

if [ -z "$1" ]
    then
    echo "Missing first parameter, NEW_PROJECT_NAME"
    echo "Usage: go_make_mod.sh {NEW_PROJECT_NAME}"
    exit 1
fi

NEW_PROJECT=$1
NEW_PROJECT_PATH="./$1"
MAKE_FILE_PATH="~/src/bash_scripts/go_make_mod/"
GITHUB_USER=stevelan

if [[ -f $NEW_PROJECT_PATH ]]
then
    echo "$NEW_PROJECT_PATH already exists on your filesystem."
    exit 2
fi

echo "Making go module ($NEW_PROJECT)"
mkdir $NEW_PROJECT_PATH 
echo "Copying makefile from $MAKE_FILE_PATH"
cp $MAKE_FILE_PATH/makefile $NEW_PROJECT_PATH
echo "Copying main_archetype.go from $MAKE_FILE_PATH"
cp $MAKE_FILE_PATH/main_archetype.go $NEW_PROJECT_PATH/$NEW_PROJECT.go
echo "Making README.md"
cat <<'EOF' > $NEW_PROJECT/README.md
#$NEW_PROJECT.go
Simple go script with single source and mod file in root directory
##Getting started
Install required tools with \`make wintools`
Build the project with `make build` will produce a binary in the root of the project directory
Clean the project with `make clean` 
##TODO - Adopt and describe a project layout from : https://github.com/golang-standards/project-layout
EOF
echo "Initialising go module $NEW_PROJECT"
go mod init $NEW_PROJECT_PATH
cd $NEW_PROJECT_PATH
echo "Changing directories to $NEW_PROJECT_PATH"
echo "Initialising git repo"
git init && git add 
git commit -m "Initial commit for $NEW_PROJECT"
git remote add origin git@github.com:$GITHUB_USER/$NEW_PROJECT
echo "Go module made"
