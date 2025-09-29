FROM node:20.18.0 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli@19

COPY . .

RUN ng build --configuration=production

FROM nginx:latest

COPY --from=build app/dist/sawa-ui/browser /usr/share/nginx/html
COPY ./nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
