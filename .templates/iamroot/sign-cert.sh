SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath "$SCRIPT_DIR")

csr_file=$1
signed_file="cert_$(cat serial).cert.pem"

echo "Current directory: $SCRIPT_DIR"
pushd $SCRIPT_DIR

if [[ -z "$CERTIFICATE_PWD" ]]; then
  echo "Error: CERTIFICATE_PWD is not set. Exiting."
  exit 1 # Exit with a non-zero status to indicate an error
fi

openssl ca -config openssl.cnf -extensions v3_intermediate_ca -batch \
      -days 3650 -notext -md sha256 \
      -passin pass:"$CERTIFICATE_PWD" \
      -in $csr_file \
      -out $signed_file

popd
#rm -- "$0"
