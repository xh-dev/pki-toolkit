SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )
SCRIPT_DIR=$(realpath "$SCRIPT_DIR/..")
pushd $SCRIPT_DIR

cert_file=$1

cert_data="$(openssl x509 -noout -text -in $cert_file|grep Subject:)"
function get_value(){
	v=$1
	echo $cert_data | grep -Po "$v"
}
echo "{\"C\":\"$(get_value '(?<=C = )(.*)(?=, ST)')\",\"ST\":\"$(get_value '(?<=ST = )(.*)(?=, L)')\", \"L\":\"$(get_value '(?<=L = )(.*)(?=, O )')\",\"O\":\"$(get_value '(?<=O = )(.*)(?=, OU)')\",\"OU\":\"$(get_value '(?<=OU = )(.*)(?=, CN)')\",\"CN\":\"$(get_value '(?<=CN = )(.*)(?=, emailAddress)')\",\"email\":\"$(get_value '(?<=emailAddress = )(.*)$')\" }" | jq

popd
