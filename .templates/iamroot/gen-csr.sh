SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath "$SCRIPT_DIR")

echo "Current directory: $SCRIPT_DIR"
pushd $SCRIPT_DIR >/dev/null

if [[ -z "$CERTIFICATE_PWD" ]]; then
  echo "Error: CERTIFICATE_PWD is not set. Exiting."
  exit 1 # Exit with a non-zero status to indicate an error
fi

openssl req -config openssl.cnf -new -sha256 \
      -passin pass:"$CERTIFICATE_PWD" \
      -key ca.key.pem \
      -out ca.csr.pem

echo "************* Complete generating the CSR file *************"
popd > /dev/null
#rm -- "$0"
