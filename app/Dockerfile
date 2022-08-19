FROM node:lts AS builder

USER node

RUN mkdir -p /home/node/build

WORKDIR /home/node/build

COPY --chown=node package.json package-lock.json ./

RUN npm install

COPY --chown=node . .

RUN npm run build

FROM node:lts-alpine

USER node

WORKDIR /app

COPY --from=builder /home/node/build  .

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "npm", "run", "dev", "--", "--public" ]
