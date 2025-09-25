SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=realpath $SCRIPT_DIR

echo "Current directory: $SCRIPT_DIR"
[[ -z "${CERTIFICATE_PWD}" ]] && MyVar="$(openssl rand -base64 32)" || MyVar="${CERTIFICATE_PWD}"
CERTIFICATE_PWD=$MyVar
unset MyVar
echo "Password used: $CERTIFICATE_PWD"

cd $SCRIPT_DIR
rm -fr crl newcerts
mkdir crl newcerts
chmod 700 private
touch index.txt
echo 1000 > serial

rm -fr openssl.cnf
cp .templates/root-config.txt openssl.cnf
sed -i "s|^\(dir[ ]\+=[ ]\+\).*$|\1$SCRIPT_DIR|g" openssl.cnf

