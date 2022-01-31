postgres:
	docker run --name postgres14 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123 -d postgres
createdb:
	docker exec -it postgres14 createdb --username=root --owner=root simplebank
dropdb:
	docker exec -it postgres14 dropdb simplebank
migrateup:
	migrate -path db/migration -database "postgresql://root:123@localhost:5432/simplebank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:123@localhost:5432/simplebank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY:postgres createdb dropdb migrateup migratedown sqlc test