SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath "$SCRIPT_DIR")

csr_file=$1
signed_file="cert_$(cat serial).cert.pem"
signed_chain_file="cert_$(cat serial).cert.chain.pem"

echo "Current directory: $SCRIPT_DIR"
pushd $SCRIPT_DIR

if [[ -z "$CERTIFICATE_PWD" ]]; then
  echo "Error: CERTIFICATE_PWD is not set. Exiting."
  exit 1 # Exit with a non-zero status to indicate an error
fi

openssl ca -config openssl.cnf -extensions server_cert -batch \
      -days 3650 -notext -md sha256 \
      -passin pass:"$CERTIFICATE_PWD" \
      -in $csr_file \
      -out $signed_file

cat ca.cert.chain.pem $signed_file  > $signed_chain_file
popd
#rm -- "$0"
