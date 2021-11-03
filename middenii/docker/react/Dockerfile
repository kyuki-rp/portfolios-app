FROM node:16-alpine

WORKDIR /var/www/app

RUN npm init -y
RUN npm i -D webpack webpack-cli webpack-dev-server typescript ts-loader @types/react @types/react-dom
RUN npm i react react-dom

ENTRYPOINT ["npx", "webpack", "serve"]