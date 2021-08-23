# AWS TF Basic Repo

##
This repo is an Example of how to use the key_automation module

It requires 3 variables: ssh_key_name, upload_new_key, pub_key 


### Inputs
Variable  | Suggested Contents
------------- | -------------
my_ip | your ip address // in terminal type curl http://ifconfig.me
user | username that you want your instance to be associated with
region | Something like "us-east-2"
ssh_key_name | you ssh key that should already be uploaded into aws key can also be created when run
upload_new_key | can be "y" or anythine else "y" is the only variable that will be accepted to upload a new key
pub_key | This can be blank or your personal SSH key. If this is blank then run the shell script included to extract the the .pem private key

### Outputs
IP Address


