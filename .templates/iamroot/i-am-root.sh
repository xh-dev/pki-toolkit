SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath $SCRIPT_DIR)

echo "Current directory: $SCRIPT_DIR"
[[ -z "${CERTIFICATE_PWD}" ]] && MyVar="$(openssl rand -base64 32)" || MyVar="${CERTIFICATE_PWD}"
CERTIFICATE_PWD=$MyVar
unset MyVar
echo "Password used: $CERTIFICATE_PWD"
pushd $SCRIPT_DIR

cd $SCRIPT_DIR
rm -fr crl newcerts
mkdir crl newcerts
touch index.txt
echo 1000 > serial

rm -fr openssl.cnf
cp .templates/root-config.txt openssl.cnf
sed -i "s|^\(dir[ ]\+=[ ]\+\).*$|\1$SCRIPT_DIR|g" openssl.cnf

cp -fr .templates/common .
./common/create-key.sh ca.key.pem

cp .templates/iamroot/gen-self-sign-cert.sh .
cp .templates/iamroot/sign-cert.sh .

echo "Complete generating the CA key as ca.key.pem"
echo "Please update the openssl.cnf [req_distinguished_name] section for the certificate sign details"
echo "And then....execute gen-self-sign-cert.sh for generation"
rm i-am-*.sh

popd
