# run docker against a volume created with docker volume create
#
#docker container prune -f
#Might need extra ram during dump/load
docker run -d --rm --name chessdb_pg -p 5442:5432 -v chessdb_data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password timescale/timescaledb:latest-pg14
#docker run -d --rm --name chessdb_pg -m 1G -p 5442:5432 -v chessdb_data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password timescale/timescaledb:latest-pg14
