cur_path=$(realpath .)
cp -f .templates/app-config.txt openssl.cnf
sed -i "s|^\(dir[ ]\+=[ ]\+\).*$|\1$cur_path|g" openssl.cnf
