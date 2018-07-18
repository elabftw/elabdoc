# this script will generate a self-signed certificate and the dhparam file

 # here we generate a random CN because of this bug:
# https://bugzilla.redhat.com/show_bug.cgi?id=1204670
# https://bugzilla.mozilla.org/show_bug.cgi?id=1056341
# this way there is no more hangs
randcn=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 12 | xargs)
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 9999 \
    -nodes \
    -x509 \
    -subj "/C=FR/ST=France/L=Paris/O=elabftw/CN=$randcn" \
    -keyout server.key \
    -out server.crt

openssl dhparam -out dhparam.pem 2048
