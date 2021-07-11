#!/bin/bash
# 
# Generate an RS256 key pair for IOT Core devices.
#
openssl genpkey -algorithm RSA -out rsa_private.pem -pkeyopt rsa_keygen_bits:2048
openssl rsa -in rsa_private.pem -pubout -out rsa_public.pem

