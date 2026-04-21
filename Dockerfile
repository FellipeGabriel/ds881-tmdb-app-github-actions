FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ARG TMDB_API_KEY
RUN echo "EXPO_PUBLIC_TMDB_API_KEY=${TMDB_API_KEY}" > .env
RUN npx expo export --platform web

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
