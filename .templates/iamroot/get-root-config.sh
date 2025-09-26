cur_path=$(realpath .)
cp -f .templates/root-config.txt openssl.cnf
sed -i "s|^\(dir[ ]\+=[ ]\+\).*$|\1$cur_path|g" openssl.cnf
