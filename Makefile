include .env
DC = $(SUDO) docker-compose -f $(YML)
DUMP = /docker-entrypoint-initdb.d/dump.sql
PY = $(DC) exec dms-backend
MNG = $(DC) exec dms-backend python manage.py
NODE = $(DC) exec dms-frontend

#======================= CONTAINERS_MANAGEMENT =========================
#=======================================================================
# build and run containers and remove orphan containers
buildup:
	$(DC) up --build --remove-orphans
up:
	$(DC) up
down:
	$(DC) down
# down + volumes
down-v:
	$(DC) down -v
logs:
	$(DC) logs

#======================= POSTGRESQL_DB =================================
#=======================================================================
db-dump:
	$(DC) exec postgres /bin/sh -c\
	  "pg_dump $(DATABASE_NAME) -U $(DATABASE_USERNAME) -h $(DATABASE_HOST) > $(DUMP)"
db-load:
	$(DC) exec postgres /bin/sh -c\
	"psql -d $(DATABASE_NAME) -U $(DATABASE_USERNAME) -h $(DATABASE_HOST) < $(DUMP)"

#======================= PYTHON_DJANGO =================================
#=======================================================================

# open Django terminal
shell:
	$(MNG) shell
# apply changes to database
migrate:
	$(MNG) migrate --noinput
# check for changes in database
makemigrations:
	$(MNG) makemigrations
# create new superuser for admin django login
superuser:
	$(MNG) createsuperuser
collectstatic:
	$(MNG) collectstatic --no-input --clear
jupyter:
	$(MNG) shell_plus --notebook
db-diagram:
	$(MNG) graph_models utils users administrative_area civic_structure landform tourist_attraction -g -n -o db_diagram.png
flake8:
	$(PY) flake8 .
black:
	$(PY) black --check .
black-diff:
	$(PY) black --diff .
black-exec:
	$(PY) black .
pytest:
	$(PY) pytest -p no:warnings --cov=.
pytest-html:
	$(PY) pytest -p no:warnings --cov=. --cov-report html
isort:
	$(PY) isort . --check-only --skip venv --skip migrations
isort-diff:
	$(PY) isort . --diff --skip venv --skip migrations
isort-exec:
	$(PY) isort . --skip venv --skip migrations


#======================= NODEJS_REACT ==================================
#=======================================================================

build-node:
	$(NODE) npm run build
eslint:
	$(NODE) npm run lint
prettier:
	$(NODE) npm run format