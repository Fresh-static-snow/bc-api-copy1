seed:
	PGPASSWORD=pass psql -U bc -d bc -f data.sql -h localhost -p 54321

build:
	docker-compose up -d --build --force-recreate

create:
	docker-compose run maincast-calendar-ruby rails db:create

reset:
	docker-compose run maincast-calendar-ruby rails db:reset

rollback:
	docker-compose run maincast-calendar-ruby rails db:rollback

migrate:
	docker-compose run maincast-calendar-ruby rails db:migrate

start:
	docker-compose up -d

clean:
	docker-compose down -v --remove-orphans
	docker-compose down --volumes --remove-orphans
	docker-compose rm -v
	docker image prune -af --filter "label=com.docker.compose.project=broadcast-shift-calendar-api"
	docker volume prune -f --filter "label=com.docker.compose.project=broadcast-shift-calendar-api"
	docker network prune -f --filter "label=com.docker.compose.project=broadcast-shift-calendar-api"
	rm -rf ./data/pg/*
	rm -rf ./broadcast-shift-calendar-api/tmp
	rm -rf ./broadcast-shift-calendar-api/log/development.log
  
setup:
	make start && make create && make seed && make migrate

full-app-start:
	make start && cd ../broadcast-shift-calendar-front && make start

full-app-setup:
	make setup && cd ../broadcast-shift-calendar-front && make start

full-app-clean:
	make clean && cd ../broadcast-shift-calendar-front && make clean
