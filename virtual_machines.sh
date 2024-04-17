#!/bin/bash

#In Cloud Shell, enter the following command to create a Debian 11 virtual machine that you can use as a test client:
gcloud compute instances create test-client  --zone=us-central1-a --image-family=debian-11 --image-project=debian-cloud --machine-type=e2-micro

#Cloud Shell, enter the following command to SSH into the test client:
gcloud compute ssh test-client --zone=us-central1-a

#To install the MySQL client software on this machine, run the following command
sudo apt-get update
sudo apt-get install -y default-mysql-client


#To log on to the database server, use the command below but change the IP address to your Cloud SQL database's IP address. (You should have pasted this address in a text file earlier in the lab. If not, you can find it in the Cloud SQL console.)
mysql --host=[Database Public IP Address] --user=root --password