cert_file=$1

cert_data="$(openssl x509 -noout -text -in $cert_file|grep Subject:)"
#echo $cert_data
function get_value(){
	v=$1
	echo $cert_data | grep -Po "$v"
}

function replacing(){
	v=$1
	echo "$v" | sed -e "s|^[\"]\(.*\)$|\1|g" | sed -e "s|^\(.*\)[\"]$|\1|" | sed -e "s|\"|\\\\\"|g"
}

C="$(get_value '(?<=C = )(.*)(?=, ST)')" 
C="$(replacing "$C")" 
#echo $C
ST="$(get_value '(?<=ST = )(.*)(?=, L)')"
ST="$(replacing "$ST")" 
#echo $ST
L="$(get_value '(?<=L = )(.*)(?=, O )')"
L="$(replacing "$L")" 
#echo $L
O="$(get_value '(?<=O = )(.*)(?=, OU)')"
O="$(replacing "$O")" 
#echo $O
OU="$(get_value '(?<=OU = )(.*)(?=, CN)')"
OU="$(replacing "$OU")" 
#echo $OU
CN="$(get_value '(?<=CN = )(.*)(?=, emailAddress)')"
CN="$(replacing "$CN")" 
#echo $CN
email="$(get_value '(?<=emailAddress = )(.*)$')"
email="$(replacing "$email")" 
#echo $email

echo "{\"C\":\"$C\",\"ST\":\"$ST\", \"L\":\"$L\",\"O\":\"$O\",\"OU\":\"$OU\",\"CN\":\"$CN\",\"email\":\"$email\"}" | jq
