docker network create --driver bridge net01
docker network ls
docker volume create ghost-volume
docker volume ls

# web tier
docker container run --name ghost --network net01 --restart=always -v ghost-volume:/var/lib/ghost -p 80:2368 -e database_client="mysql" -e database_connection_host="mysql" -e database_connection_user="root" -e database_connection_password="Passw0rd!" -e database_connection_database="ghost" ghost:1-alpine

# db tier
docker volume create mysql-volume
docker container run --name mysql --network net01 --restart=always -v mysql-volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="Passw0rd!" -e MYSQL_DATABASE="ghost" mysql:5.7

# cleanup
docker container rm `docker container ls -a -q` -f
docker image rm `docker image ls -a -q` -f
docker network prune -f
docker network ls
docker volume rm ghost-volume mysql-volume
docker volume ls