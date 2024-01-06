FROM node:20.10.0-alpine as base

WORKDIR /src/app
COPY . .
RUN npm install
RUN npm run pkg

FROM alpine:3.18

COPY --from=base /src/app/.bin/main-tugas-action /usr/local/bin/main-tugas-action
CMD [ "main-tugas-action" ]
