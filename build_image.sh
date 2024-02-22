cat ~/.ssh/id_rsa.pub > authorized_keys
docker build --build-arg USER=$USER --build-arg UID=$UID --build-arg GID=$GID . -t docker-mpi
rm -f authorized_keys
