#!/bin/sh
#
# Create a new dataset (package).
#
# The API token to be provided has to be stored in api-token.txt
#
# API doc: https://docs.ckan.org/en/2.9/api/#ckan.logic.action.create.package_create
#
# A python examples are also availabe at https://docs.ckan.org/en/2.9/api/#example-importing-datasets-with-the-ckan-api


# Configuration

# File which contains exactly an API token
FILE=api-token.txt

# CKAN API
# Please do not use the DICE instance for tests.
#API="https://ckan.dice-research.org/api/3/"
API="http://localhost:5000/api/3/"


# Run

# Get token from file
if [ ! -f "$FILE" ]; then
    echo "$FILE does not exist."
    exit
fi
TOKEN=`cat $FILE`

# Print available organization IDs (required for parameter owner_org)
echo "organization_list"
curl ${API}action/organization_list

# Create package (dataset)
curl \
    -X POST \
    -H "Authorization:$TOKEN" \
    --data-urlencode "name=script_test" \
    --data-urlencode "owner_org=dice" \
    ${API}action/package_create

