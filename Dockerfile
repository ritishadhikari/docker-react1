# Creating the builder app for the dev environment
FROM node:alpine as builder
WORKDIR './app/'
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build
#The build component will get eventually stored in  /app/build


FROM nginx  #nginx is made for production upload
# copying over the only the result of 'npm run build' over to the nginx folder.
# Not copying anything else like run npm install, etc etc. The default port which nginx uses is 80. Lecture 88. 
COPY --from=builder /app/build /usr/share/nginx/html
