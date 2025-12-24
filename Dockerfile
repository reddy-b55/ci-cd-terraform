FROM node:18-alpine AS builder

WORKDIR /app

COPY app/package*.json ./

RUN npm install --legacy-peer-deps

COPY app/ .

RUN npm run build

FROM node:18-alpine
WORKDIR /app

COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "run", "start", "--", "-p", "3000", "-H", "0.0.0.0"]
