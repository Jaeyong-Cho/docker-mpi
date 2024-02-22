docker network create --subnet=172.20.20.0/16 mpinet
docker run --name mpi-worker0 -t -d --network mpinet --ip 172.20.20.20 docker-mpi
docker run --name mpi-worker1 -t -d --network mpinet --ip 172.20.20.21 docker-mpi 
docker run --name mpi-worker2 -t -d --network mpinet --ip 172.20.20.22 docker-mpi
