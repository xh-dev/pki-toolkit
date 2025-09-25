SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath $SCRIPT_DIR)
pushd $SCRIPT_DIR

echo "Current directory: $SCRIPT_DIR"
[[ -z "${CERTIFICATE_PWD}" ]] && MyVar="$(openssl rand -base64 32)" || MyVar="${CERTIFICATE_PWD}"
CERTIFICATE_PWD=$MyVar
unset MyVar
echo "Password used: $CERTIFICATE_PWD"

cd $SCRIPT_DIR
rm -fr crl newcerts
mkdir crl newcerts
touch index.txt
echo 1000 > serial

rm -fr openssl.cnf
cp .templates/intermediate-config.txt openssl.cnf
sed -i "s|^\(dir[ ]\+=[ ]\+\).*$|\1$SCRIPT_DIR|g" openssl.cnf

cp -fr .templates/common .
./common/create-key.sh ca.key.pem

cp .templates/iamroot/gen-csr.sh .
cp .templates/iamroot/get-intermediate-config.sh .

echo "Complete generating the CA key as ca.key.pem"
echo "Please update the openssl.cnf [req_distinguished_name] section for the certificate sign details"
echo "And then....execute gen-csr.sh for generation"
rm i-am-*.sh

popd
