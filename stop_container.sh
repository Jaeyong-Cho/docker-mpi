docker stop mpi-worker0
docker stop mpi-worker1
docker stop mpi-worker2
docker rm mpi-worker0
docker rm mpi-worker1
docker rm mpi-worker2

docker network rm mpinet
