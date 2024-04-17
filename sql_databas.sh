#!/bin/bash

#Create environment variables that will be used later in the lab for your project ID and the storage bucket that will contain your data:
export PROJECT_ID=$(gcloud info --format='value(config.project)')
export BUCKET=${PROJECT_ID}-ml

#Enter the following commands to create a Cloud SQL instance:
gcloud sql instances create flights \
    --database-version=POSTGRES_13 --cpu=2 --memory=8GiB \
    --region="REGION" --root-password=Passw0rd
    
#Create an environment variable with the Cloud Shell IP address:
export ADDRESS=$(curl -s http://ipecho.net/plain)/32

#Allowlist the Cloud Shell instance for management access to your SQL instance:
gcloud sql instances patch flights --authorized-networks $ADDRESS

#Connect to the Cloud SQL instance from Cloud Shell using:
gcloud sql connect flights --user=postgres

#In the prompt that comes up, connect to the bts database:
\c bts;

#Then, run a query to obtain the 5 busiest airports:
(SELECT "Origin", COUNT(*) AS num_flights 
FROM flights GROUP BY "Origin" 
ORDER BY num_flights DESC 
LIMIT 5;)

#At the Cloud Shell command prompt, enter the following command to create a MySQL database using the CLI:
gcloud sql instances create mysql-db --tier=db-n1-standard-1 --zone=us-central1-a

#Enter the following command to set the password for the root account. Make the password something you can remember.
gcloud sql users set-password root --host=% --instance=mysql-db --password=your-password-here

#Enter the following command to connect to your Cloud SQL database using the CLI. It will take a little while for Cloud Shell's IP address to be allowlisted by the Cloud SQL network.
gcloud sql connect mysql-db --user=root --quiet

#At the mysql prompt, type the following to ensure that it works:
SHOW DATABASES;