#!/bin/sh
certtool --generate-privkey --outfile ${1}.key
sed "s/COMMONNAME/${1}/" client.tmpl > tmp-${1}.tmpl
certtool --generate-certificate --load-privkey ${1}.key --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template tmp-${1}.tmpl --outfile ${1}.crt && rm tmp-${1}.tmpl
openssl pkcs12 -export -inkey ${1}.key -in ${1}.crt -certfile ca-cert.pem -out ${1}.p12
mkdir $1 && mv $1.* $1
