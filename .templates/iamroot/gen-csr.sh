SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath "$SCRIPT_DIR")

echo "Current directory: $SCRIPT_DIR"
pushd $SCRIPT_DIR

if [[ -z "$CERTIFICATE_PWD" ]]; then
  echo "Error: CERTIFICATE_PWD is not set. Exiting."
  exit 1 # Exit with a non-zero status to indicate an error
fi

openssl req -config openssl.cnf -new -sha256 \
      -passin pass:"$CERTIFICATE_PWD" \
      -key ca.key.pem \
      -out ca.csr.pem
popd
rm -- "$0"
