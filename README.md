<h1  align="center">Data Management System Platform</h1>

This is Docker Compose development platform. Below are instructions for creating local development workflow of Python back-end, React front-end and Jupyter Notebooks. 

![Django](https://img.shields.io/badge/django-%23093E20.svg?style=for-the-badge&logo=django&logoColor=white) ![GraphQL](https://img.shields.io/badge/-GraphQL-E10098?style=for-the-badge&logo=graphql&logoColor=white) ![React](https://img.shields.io/badge/React-%23444444.svg?style=for-the-badge&logo=react&logoColor=#2361dbfb) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

## Requirements:
 - Docker
 - Docker-Compose
 - Make
 - Sibling repositories as sibling directories:
   * dms-backend
   * dms-frontend
   * dms-jupyter

## To clone whole repository and all sub-modules run:
 `git clone --recurse-submodules git@github.com:arcticportal/dms-platform.git`

## Run Development Containers

 1. Open a terminal and go to the directory where you git-pulled required repositories.
 2. **Ensure the ports 80, 3000 5432,  8000 and 8888 are not in use.**  To change used ports, edit `docker-compose.yml`.
 3. Make your own `.env` file from `.env.example` file.
 4. Run `make buildup` and wait until all containers are successfully built.

## Stop Development Containers
1. When you are done, stop the containers by going to the first terminal window and pressing Ctrl-C and `make down` command to remove containers or make down -v to also remove all related volumes.
2. Next time, to start the containers, just run `make up`. This uses the images built during the first run.
3. File with more commands is located in `dms-platform/Makefile`.

## To start Jupyter netbook:
1. Navigate to dms-platform and run `make jupyter` or inside python container run `python3 manage.py shell_plus --notebook`.
2. Copy login key from terminal output.
3. Go to `localhost:8888/` and add login key to URL.

## Development While Containers Are Running
 1. Open a terminal and go to the platform-dev directory.
 2. If `../platform-app/node_modules` or `.local` directories are missing, then
    run `make moddump`.  This populates the module directories for your
    IDE tooling to inspect.
 3. Edit the code in `../dms-frontend` and `../dms-backend` directories. Changes are visible immediately on page, no need to reload (check URLs below).
 4. To check if there is change in database tables from Django run `make makemigrations` or `make migrate` to apply changes.
 5. Run `make collectstatic` to collect static files from back-end admin panels.
 6. To save the database, run `make db-dump`.

## URLs
 + Nginx is running on `localhost'
 + React front-end is running on `localhost:3000`.
	 * **Hot-reloading:** This requires bypassing Nginx server by using `localhost:3000`.
 + Django admin panel running on `localhost/{root defined in env file}`.
 + Wagtail CMS is running on `localhost/{root defined in env file}`.
 + Strawberry GraphQL playground is on `localhost/graphiql`. More info on `dms-platform`'s Readme file.
 + Jupyter Notebook is running on `localhost:8888`, **instructions to enable server  are above**

## Deployment
------TBD
