env-up:
	docker-compose up -d --build db

env-down:
	docker-compose down

env-test:
	docker-compose up -d --build db_test

test: env-test
	mix test

run-local:
	mix phx.server

migrate:
	mix ecto.migrate