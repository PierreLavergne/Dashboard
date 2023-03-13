FROM node:16.19.1-alpine3.17 AS builder

WORKDIR /

COPY package*.json ./
COPY tsconfig*.json ./
COPY prisma ./prisma/
COPY .env .

RUN npm install

RUN npm install -g npm@9.5.1

COPY . .

FROM node:16.19.1-alpine3.17

COPY --from=builder /node_modules ./node_modules
COPY --from=builder /package*.json ./
COPY --from=builder /tsconfig*.json ./
COPY --from=builder /prisma ./prisma

EXPOSE 3000

CMD [  "npm", "run", "start:migrate:dev" ]