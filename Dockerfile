# Shared nginx runtime used by both build paths.
FROM nginx:alpine-slim AS runtime

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# CI builds the Vite assets once on the runner and uses this target to
# package the prebuilt dist directory for every requested platform.
FROM runtime AS prebuilt

COPY dist/ /usr/share/nginx/html/

# A self-contained source build remains available for local development.
FROM node:24-alpine AS source-builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM runtime AS source-built

COPY --from=source-builder /app/dist/ /usr/share/nginx/html/

# Keep `docker build .` backward-compatible by selecting the source-built
# image when no explicit target is supplied.
FROM source-built AS final
