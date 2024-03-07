# run docker against a volume created with docker volume create
#
#docker container prune -f
# Remove container after it stops
docker run -d --rm --name chessdb_pg -m 1G -p 5442:5432 -v chessdb_data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password timescale/timescaledb:latest-pg14
