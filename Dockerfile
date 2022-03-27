FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build is where the actual build lives
# separate FROMs indicate different phases, dump steps/code from before
# good way to not carry dependencies when we don't need them

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# nginx default command is to run, don't need to add a specific command
