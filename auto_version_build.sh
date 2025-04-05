#!/bin/bash

# Function to revert Maven version change
cleanup() {
  echo "Running: mvn versions:revert -q"
  mvn versions:revert -q
}

# Set the trap to call cleanup on EXIT
trap cleanup EXIT

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <maven_command>"
  echo "Example: $0 mvn clean install"
  exit 1
fi

# Get the current Git branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Set the Maven version to the branch name with -SNAPSHOT quietly
echo "Running: mvn versions:set -DnewVersion=${BRANCH}-SNAPSHOT -q"
mvn versions:set -DnewVersion=${BRANCH}-SNAPSHOT -q

# Collect all arguments into a single command string
MAVEN_COMMAND="$@"

# Print and execute the provided Maven command
echo "Running: $MAVEN_COMMAND"
eval $MAVEN_COMMAND

# The cleanup function will automatically be called here due to the trap