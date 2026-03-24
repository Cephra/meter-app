FROM node:lts-alpine AS service-v2-deps

USER node

RUN mkdir -p /home/node/monorepo
WORKDIR /home/node/monorepo

COPY --chown=node package*.json ./
COPY --chown=node packages/service-v2/package*.json ./packages/service-v2/

RUN npm ci --workspace @meter-app/service-v2 --include-workspace-root=false

FROM node:lts-alpine AS service-v2-prod-deps

USER node

RUN mkdir -p /home/node/monorepo
WORKDIR /home/node/monorepo

COPY --chown=node package*.json ./
COPY --chown=node packages/service-v2/package*.json ./packages/service-v2/

RUN npm ci --omit=dev --workspace @meter-app/service-v2 --include-workspace-root=false

FROM service-v2-deps AS service-v2-builder

WORKDIR /home/node/monorepo/packages/service-v2
ARG DATABASE_URL=postgres://postgres:postgres@db:5432/postgres
ENV DATABASE_URL=${DATABASE_URL}
COPY --chown=node packages/service-v2/ ./
RUN npm run prisma:generate && npm run build

FROM service-v2-prod-deps AS service-v2-runtime-deps

COPY --from=service-v2-builder /home/node/monorepo/node_modules/@prisma/client /home/node/monorepo/node_modules/@prisma/client
COPY --from=service-v2-builder /home/node/monorepo/node_modules/.prisma /home/node/monorepo/node_modules/.prisma

FROM node:lts-alpine AS service-v2-runner

USER node
WORKDIR /service

COPY --from=service-v2-deps /home/node/monorepo/packages/service-v2/package.json ./
COPY --from=service-v2-runtime-deps /home/node/monorepo/node_modules/ ./node_modules/
COPY --from=service-v2-builder /home/node/monorepo/packages/service-v2/dist ./dist
COPY --from=service-v2-builder /home/node/monorepo/packages/service-v2/prisma ./prisma

ENV HOST=0.0.0.0 PORT=3002
EXPOSE ${PORT}

CMD ["node", "dist/main.js"]

FROM node:lts-alpine AS web-deps

USER node

RUN mkdir -p /home/node/monorepo
WORKDIR /home/node/monorepo

COPY --chown=node package*.json ./
COPY --chown=node packages/web/package*.json ./packages/web/

RUN npm ci --workspace @meter-app/web --include-workspace-root=false

FROM web-deps AS web-builder

WORKDIR /home/node/monorepo/packages/web
COPY --chown=node packages/web/ ./
RUN npm run build

FROM nginx:alpine AS web-runner

COPY --from=web-builder /home/node/monorepo/packages/web/dist /usr/share/nginx/html
COPY docker/nginx/web.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
