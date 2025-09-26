SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath $SCRIPT_DIR)

echo "Current directory: $SCRIPT_DIR"
[[ -z "${CERTIFICATE_PWD}" ]] && MyVar="$(openssl rand -base64 32)" || MyVar="${CERTIFICATE_PWD}"
CERTIFICATE_PWD=$MyVar
unset MyVar
echo "Password used: $CERTIFICATE_PWD"
pushd $SCRIPT_DIR

cp -fr .templates/common .
./common/create-key.sh ca.key.pem

cp .templates/iamroot/get-app-config.sh common/get-config.sh
./common/get-config.sh
cp .templates/iamroot/gen-csr.sh .

echo "Complete generating the Certificate key as ca.key.pem"
echo "Please update the openssl.cnf [req_distinguished_name] section for the certificate sign details"
echo "And then....execute gen-csr.sh for generating CSR file"
rm i-am-*.sh

popd
