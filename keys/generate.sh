#!/usr/bin/env bash
if [ -f private.key ]; then
   echo "already generated"
   exit 1
fi
#openssl ecparam -name prime256v1 -genkey -noout -out private.key
openssl ec -in private.key -pubout -out public.pem
#go install github.com/jphastings/jwker/cmd/jwker@latest
jwker public.pem > public.json
