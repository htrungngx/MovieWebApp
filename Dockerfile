FROM alpine
WORKDIR /usr/src/app
COPY package.json ./
RUN apk add --update nodejs npm && npm install .
COPY . .
EXPOSE 3000
CMD ["npm", "start"]