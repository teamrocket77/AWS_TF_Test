#! /bin/bash

result=`grep -e '-----BEGIN RSA PRIVATE KEY-----.*-----END RSA PRIVATE KEY-----' terraform.tfstate`
echo $result >> priv_key.pem
sed -i '' 's/\\n/\
/g' priv_key.pem 
sed -i '' 's/\"//g' priv_key.pem
sed -i '' 's/private_key_pem: //g' priv_key.pem
sed -i '' -e '$ d' priv_key.pem
chmod 400 priv_key.pem