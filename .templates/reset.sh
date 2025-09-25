
CUR_DIR="$(pwd)"
CUR_DIR=$(realpath $CUR_DIR)
echo "Current directory: $SCRIPT_DIR"

pushd $CUR_DIR
rm -fr ca.*.pem certs crl newcerts private serial openssl.cnf create-key.sh gen-self-sign-cert.sh index.txt common gen-*.sh
cp -fr .templates/common .
cp .templates/iamroot/i-am-*.sh .
popd
