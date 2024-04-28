#!/usr/bin/env bash
URL=$(./url)
payload=$(printf "%s" "$(./req)" | ../encode)
protected=$(printf "%s" "$(./protected)" | ../encode)

_signedECText=$(printf "%s" $protected.$payload |../sign)

_ec_r="$(echo "$_signedECText" | head -n 2 | tail -n 1 | cut -d : -f 4 | tr -d "\r\n")"
_ec_s="$(echo "$_signedECText" | head -n 3 | tail -n 1 | cut -d : -f 4 | tr -d "\r\n")"
while [ "${#_ec_r}" -lt "64" ]; do
  _ec_r="0${_ec_r}"
done
while [ "${#_ec_s}" -lt "64" ]; do
  _ec_s="0${_ec_s}"
done
signature=$(printf "%s" "$_ec_r$_ec_s" | xxd -r -p | ../encode)
#jq -n ".protected=\"$protected\" | .payload = \"$payload\" | .signature = \"$signature\"" | jose-util verify -key ../identity/identity.key
http --unsorted -v $URL Content-Type:application/jose+json protected="$protected" payload="$payload" signature="$signature" | tee response.txt

