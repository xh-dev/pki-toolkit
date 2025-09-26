key_info_file=$1
config_file=$2

key_info_data=$(cat $key_info_file)
C=$(echo $key_info_data | jq -r ".C")
ST=$(echo $key_info_data | jq -r ".ST")
L=$(echo $key_info_data | jq -r ".L")
O=$(echo $key_info_data | jq -r ".O")
OU=$(echo $key_info_data | jq -r ".OU")
CN=$(echo $key_info_data | jq -r ".CN")
email=$(echo $key_info_data | jq -r ".email")

sed -i "s|^\(C[ ]\+= \+\).*$|\1$C|g" $config_file
sed -i "s|^\(ST[ ]\+= \+\).*$|\1$ST|g" $config_file
sed -i "s|^\(L[ ]\+= \+\).*$|\1$L|g" $config_file
sed -i "s|^\(O[ ]\+= \+\).*$|\1$O|g" $config_file
sed -i "s|^\(OU[ ]\+= \+\).*$|\1$OU|g" $config_file
sed -i "s|^\(CN[ ]\+= \+\).*$|\1$CN|g" $config_file
sed -i "s|^\(emailAddress[ ]\+= \+\).*@.*$|\1$email|g" $config_file
