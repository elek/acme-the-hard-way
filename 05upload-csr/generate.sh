#!/usr/bin/env bash
rm private.key
rm req.csr
rm req.der
openssl req -nodes -newkey rsa:2048 -keyout private.key -out req.csr
openssl req -in req.csr -outform DER -out req.der
