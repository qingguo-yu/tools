#!/bin/bash
BRANCH=$(git rev-parse --abbrev-ef HEAD)
mvn versions:set -DnewVersion=${BRANCH}-SNAPSHOT
mvn versions:revert
