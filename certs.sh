#!/bin/sh
VERSION=$(openssl version)
clear

echo ""
echo -e "\033[33;32mSSL CERT GENER8OR     by      Chris Jones (https://c-j.tech) "
echo ""

reset_color()
{
    echo -ne "\033[0m"
}

count() 
{
    TIME=$1
    COUNT=0
    while [ $COUNT -lt $TIME ]
    do
    sleep .1
    echo -n "."
    COUNT=$(( $COUNT + 1 ))
    done
}

# check_env_var() 
# {
# echo -ne "Checking ENV $1 VARIABLE is set: "
# VAL=printenv $1
# echo "$VAL"
# if [ -z "$1" ] 
# then
# echo -e "\033[33;31m Error"
# # echo # Continued from above example
# echo "$1 environment variable not set, please check you have updated/created the .env file"
# exit 1
# else 
# echo -en "\033[33;32m OK "
# printenv $1

# fi
# reset_color
# }

reset_color


echo -n "Checking ENV PASSWORD VARIABLE is set:         "
if [ -z "$PASSWORD" ] 
then
echo -e "\033[33;31m Error"
# echo # Continued from above example
echo "Password environment variable not set, please check you have updated/created the .env file"
exit 1
else 
echo -e "\033[33;32m OK"
fi 
reset_color

echo -n "Checking COMMON_NAME  VARIABLE is set:         "
if [ -z "$COMMON_NAME" ] 
then
echo -e "\033[33;31m Error"
# echo # Continued from above example
echo "COMMON_NAME environment variable not set, please check you have updated/created the .env file"
exit 1
else 
echo -e "\033[33;32m OK"
fi 
reset_color 

echo -n "Checking ENV PASSWORD VARIABLE length:         "
if [ ${#PASSWORD} -lt 4 ]
then
echo -e "\033[33;31m Error"
exit 1
else 
echo -e "\033[33;32m OK"
fi
 
reset_color
echo -n "STEP 1: Generating server key:                  "
openssl genrsa -des3 -out server.key -passout env:PASSWORD 2048 &> /dev/null
count 5
echo -e "\033[33;32m Done"

reset_color
echo -n "STEP 2: Creating server key:                    "
openssl req -new -key server.key -out server.csr -passin env:PASSWORD -subj "/CN=elite-lms.com" &> /dev/null
count 5
echo -e "\033[33;32m Done"

reset_color
echo -n "STEP 3: Copying server key:                     "
cp server.key server.key.org
count 5
echo -e "\033[33;32m Done"

reset_color
echo -n "STEP 4: Creating RSA key:                       "
openssl rsa -in server.key.org -out server.key -passin env:PASSWORD &> /dev/null
count 5
echo -e "\033[33;32m Done"

reset_color
echo -n "STEP 5: Signing Key:                            "
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt &> /dev/null
count 5
echo -e "\033[33;32m Done"

reset_color
echo -n "STEP 6: Copying certs:                          "
cp server.crt /certs/
cp server.key /certs/
count 5
echo -e "\033[33;32m Done"

exit

check