SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR
key_name=$1
echo "generating key with password[$CERTIFICATE_PWD] to path $SCRIPT_DIR/$key_name"
openssl genrsa -aes256 -passout pass:"$CERTIFICATE_PWD" -out $SCRIPT_DIR/$key_name 8192
popd
