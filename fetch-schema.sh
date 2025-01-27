#!/bin/bash

# Load API key from .env or environment variable
API_KEY=$(cat .env | grep GRAPHQL_API_KEY | cut -d '=' -f2)

# Backup the original config file
cp apollo-codegen-config.json apollo-codegen-config.backup.json

# Inject API key into the config file
jq --arg apiKey "$API_KEY" '.schemaDownload.headers.Authorization = "ApiKey \($apiKey)"' apollo-codegen-config.backup.json > apollo-codegen-config.json

# Run the Apollo CLI to fetch the schema
./apollo-ios-cli fetch-schema

# Restore the original config file to remove sensitive data
mv apollo-codegen-config.backup.json apollo-codegen-config.json
