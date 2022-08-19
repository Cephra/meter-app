# FastAPI

FastAPI started as a sample project for a simple web application with a database (PostgreSQL), service (Loopback.io 4) and front end (Nuxt 3).
A meter data management system is now being developed here.

## Directory Structure

The app has the following directory structure:

* `app`: This directory contains the Nuxt.js application code.
	+ `app.vue`: The main entry point for the application.
	+ `Dockerfile`: A Docker file used to build a container image for the application.
	+ `pages`: Directory containing page-level components.
	+ `layouts`: Directory containing reusable layout components.
	+ `stores`: Directory containing Pinia store configurations.
	+ `nuxt.config.ts`: The main configuration file for Nuxt.js.
	+ `server`: Directory containing server-side code for the application.
	+ `assets`: Directory containing static assets such as CSS files and images.
	+ `components`: Directory containing reusable UI components.
* `service`: This directory contains the backend API code using LoopBack.
	+ `src`: Directory containing source code for the service.
		- `__tests__`: Directory containing unit tests for the service.
		- `repositories`: Directory containing database repository implementations.
		- `controllers`: Directory containing API controllers.
		- `models`: Directory containing data models used by the service.
	+ `Dockerfile`: A Docker file used to build a container image for the service.
* `docs`: This directory contains documentation files for the application.

## Starting the Local Environment with Docker

This project can be run entirely within Docker.
To start the local environment, simply use the following command:

```bash
docker-compose --profile all up -d
```

(Note: This is a simple instruction on how to start the local development environment using Docker Compose. The `--profile all` option tells Docker Compose to use all defined profiles, and `up -d` starts the containers in detached mode.)

## Login to the Database using Docker Compose

The provided `docker-compose` file sets up a PostgreSQL database, a PGAdmin server for managing the database, and three separate services: a Node.js service, and an application service. To login to the database, follow these steps:

**Step 1: Access the PGAdmin Web Interface**

1. Open a web browser and navigate to `http://localhost:5000`. This is the default URL for the PGAdmin server.
2. Log in with the credentials provided:
* Email: root@db.com
* Password: root

**Step 2: Connect to the Database**

Once logged in, you'll be presented with a list of available servers. Click on the "Connect" button next to the "postgres" server.

**Step 3: Provide Login Credentials**

Enter the login credentials for the database:
* Username: root
* Password: root

**Step 4: Access the Database**

After logging in, you'll be taken to the PostgreSQL database console. You can now execute SQL queries, view database schema, and perform other administrative tasks.

By following these steps, you should be able to successfully login to the PostgreSQL database using the provided Docker Compose configuration.

**Test Data**

Upon starting the local environment with Docker, you'll notice that some initial data is automatically inserted into the database. This is thanks to the `./docker/db/sql` directory, which contains SQL scripts that are executed by the PostgreSQL container when it starts up. These scripts populate the database with some basic data, such as tables and sample records, which can be used for testing and development purposes. This feature saves you the time and effort of manually inserting initial data into the database, allowing you to hit the ground running.