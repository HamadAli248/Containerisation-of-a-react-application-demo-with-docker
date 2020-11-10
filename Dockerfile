FROM node:alpine as build

ENV APP_NAME=Your-application-name
ENV APP_HOME=/app

RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}

COPY package.json ./
COPY pacakage.json ./
RUN npm install

COPY . ./

RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 8443
CMD [“nginx”,”-g”,”daemon off;”]
