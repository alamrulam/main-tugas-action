# Stage 1: Build aplikasi Node.js
FROM node:20.10.0-alpine as base

WORKDIR /src/app

# Copy file .npmrc jika diperlukan (misalnya, untuk menyertakan token autentikasi private registry)
COPY .npmrc .npmrc

# Copy file package.json dan package-lock.json terlebih dahulu untuk memanfaatkan cache Docker layer
COPY package*.json ./

# Install dependensi
RUN npm install

# Copy seluruh sumber kode
COPY . .

# Build aplikasi menggunakan npm run pkg
RUN npm run pkg

# Stage 2: Image Alpine yang lebih kecil untuk runtime
FROM alpine:3.18

WORKDIR /usr/local/bin/

# Copy binari hasil build dari stage pertama
COPY --from=base /src/app/.bin/main-tugas-action .

# Setelah ini, tidak perlu menjalankan perintah CMD "main-tugas-action" karena itu akan menjadi default
