SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath "$SCRIPT_DIR")

echo "Current directory: $SCRIPT_DIR"

if [[ -z "$CERTIFICATE_PWD" ]]; then
  echo "Error: CERTIFICATE_PWD is not set. Exiting."
  exit 1 # Exit with a non-zero status to indicate an error
fi
pushd $SCRIPT_DIR > /dev/null
openssl req -config openssl.cnf \
      -key ca.key.pem \
      -passin pass:"$CERTIFICATE_PWD" \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out ca.cert.pem
popd > /dev/null

cp ca.cert.pem ca.cert.chain.pem

rm openssl.cnf
rm -- "$0"
