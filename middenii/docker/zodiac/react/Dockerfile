FROM node:16-alpine

WORKDIR /var/www/app

RUN npm init -y
RUN npm install -D webpack webpack-cli webpack-dev-server typescript ts-loader @types/react @types/react-dom react-router-dom @types/react-router-dom axios bootstrap css-loader style-loader react-bootstrap history@4.10.1 
RUN npm install react react-dom

ENTRYPOINT ["npx", "webpack"]
ENTRYPOINT ["npx", "webpack", "serve"]
ENTRYPOINT ["/bin/sh"]
