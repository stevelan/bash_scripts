#!/bin/bash
# Initialises a new go module with archetypal makefile, skeleton README, and $1.go with main function

if [ -z "$1" ]
    then
    echo "Missing first parameter, NEW_PROJECT_NAME"
    echo "Usage: go_make_mod.sh {NEW_PROJECT_NAME}"
    exit 1
fi

NEW_PROJECT=$1
NEW_PROJECT_PATH=./$1
MAKE_FILE_PATH=~/src/bash_scripts/go_make_mod/
GITHUB_USER=stevelan

echo "Making go module ($NEW_PROJECT)"

if [[ -e "$NEW_PROJECT_PATH" ]]
then
    echo "$NEW_PROJECT_PATH already exists on your filesystem."
    exit 2
fi

mkdir $NEW_PROJECT_PATH 
echo "Copying makefile from $MAKE_FILE_PATH"
cp ${MAKE_FILE_PATH}makefile.archetype ${NEW_PROJECT_PATH}/makefile
echo "Copying main_archetype.go from $MAKE_FILE_PATH"
cp ${MAKE_FILE_PATH}main_go.archetype ${NEW_PROJECT_PATH}/${NEW_PROJECT}.go

echo "Making README.md"
echo "#${NEW_PROJECT}.go" > ${NEW_PROJECT_PATH}/README.md
cat <<'EOF' > ${NEW_PROJECT_PATH}/README.md
Simple go script with single source and mod file in root directory
##Getting started
Install required tools with \`make wintools`
Build the project with `make build` will produce a binary in the root of the project directory
Clean the project with `make clean` 
##TODO - Adopt and describe a project layout from : https://github.com/golang-standards/project-layout
EOF

echo "Changing directories to $NEW_PROJECT_PATH"
cd $NEW_PROJECT_PATH

echo "Initialising go module $NEW_PROJECT"
go mod init $NEW_PROJECT

echo "Initialising git repo"
git init && git add .
git commit -m "Initial commit for $NEW_PROJECT"
git remote add origin git@github.com:$GITHUB_USER/$NEW_PROJECT

pwd
echo "Go module made ($NEW_PROJECT)"
