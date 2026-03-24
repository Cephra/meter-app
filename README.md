# MeterApp

MeterApp is a meter data management system with PostgreSQL, a NestJS backend and a Vue + Vite frontend.

## Directory Structure

- `packages/service-v2`: NestJS + Prisma backend
- `packages/web`: Vue + Vite frontend
- `packages/shared-api`: generated OpenAPI types shared with the frontend
- `docs`: project documentation

## Starting the Local Database with Docker

To start PostgreSQL locally for development, run:

**Attention**: If you are on Linux you should run `echo "UID=$UID" > .env` within the project root beforehand. This will ensure docker compose runs the containers with the correct UID for an optimal local DX.

```bash
docker compose up -d db
```

Keycloak now uses its own dedicated PostgreSQL service, `keycloak-db`, instead of sharing the app database.

## Login to the Database using Docker Compose

The provided `docker-compose.yml` file sets up PostgreSQL and PGAdmin for local development. To login to the database, follow these steps:

**Step 1: Access the PGAdmin Web Interface**

1. Open a web browser and navigate to `http://localhost:5000`. This is the default URL for the PGAdmin server.
2. Log in with the credentials provided:

- Email: root@db.com
- Password: root

**Step 2: Connect to the Database**

Once logged in, you'll be presented with a list of available servers. Use `db` for the application database or `keycloak-db` for Keycloak.

**Step 3: Provide Login Credentials**

Enter the login credentials for the database:

- For `db`: username `postgres`, password `postgres`
- For `keycloak-db`: username `keycloak`, password `keycloak`

**Step 4: Access the Database**

After logging in, you'll be taken to the PostgreSQL database console. You can now execute SQL queries, view database schema, and perform other administrative tasks.

By following these steps, you should be able to successfully login to the PostgreSQL database using the provided Docker Compose configuration.

**Test Data**

When starting the local environment with Docker, the application database is initialized using SQL scripts from `./docker/db/sql/app`. Keycloak uses a separate database service (`keycloak-db`), which is initialized independently from scripts in `./docker/db/sql/keycloak`. This setup keeps application and identity data isolated while still providing a fully seeded local environment.

## Development

### 1. Install dependencies

```bash
npm install
```

### 2. Start only the database

```bash
docker compose up -d db
```

### 3. Configure backend env

`service-v2` uses `DATABASE_URL`.

Set it in `envs/service.local.env` (example):

```bash
DATABASE_URL=postgres://postgres:postgres@localhost:5432/postgres
```

### 4. Start the backend

```bash
npm run dev:service
```

Alternative (containerized service):

```bash
docker compose up -d --build service-v2
```

### 5. Start the frontend

```bash
npm run dev:web
```

Alternative (containerized frontend):

```bash
docker compose up -d --build web
```

### 6. URLs

- Web: `http://localhost:5173`
- Web (containerized): `http://localhost:3001`
- API: `http://localhost:3002`
- Swagger UI: `http://localhost:3002/docs`
- OpenAPI JSON (runtime): `http://localhost:3002/docs/openapi.json`

### 7. Regenerate OpenAPI and shared types

```bash
DATABASE_URL=postgres://postgres:postgres@localhost:5432/postgres npm run openapi
```

## Screenshots

### Gas Report

![Gas](docs/assets/reports.png)

### Input Form

![Input](docs/assets/input.png)
