.PHONY: start stop restart logs update

start:
	docker compose up -d

stop:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

update:
	docker compose pull && docker compose up -d
