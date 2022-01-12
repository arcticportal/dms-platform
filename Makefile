include .env
DC = $(SUDO) docker-compose -f $(YML)
DUMP = /docker-entrypoint-initdb.d/dump.sql
PY = $(DC) exec dms-backend
MNG = $(DC) exec dms-backend python manage.py

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
	$(DC) exec postgres sh -c\
	  "pg_dump $(DATABASE_NAME) -U $(DATABASE_USERNAME) >$(DUMP)"
db-load:
	$(DC) exec postgres /bin/sh -c\
	"psql -d $(DATABASE_NAME) -U $(DATABASE_USERNAME) <$(DUMP)"

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
	$(PY) isort . --check-only --skip env --skip migrations
isort-diff:
	$(PY) isort . --diff --skip env --skip migrations
isort-exec:
	$(PY) isort . --skip env --skip migrations
