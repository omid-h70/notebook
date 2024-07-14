up:
	@echo "Starting Docker images..."
	docker-compose up -d
	@echo "Docker images started!"

clean:
	@echo "Clean and Build"
	docker-compose down -v
	docker-compose build --no-cache
	docker-compose up --force-recreate
	@echo "Clean Build Done!"

down:
	@echo "Stopping docker compose..."
	docker-compose down -v
	@echo "Done!"
