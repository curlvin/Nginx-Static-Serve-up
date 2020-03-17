####### BUILD PHASE ##########
#specify base image for build phase
FROM node:alpine AS builder 

#specify workdir
WORKDIR /app

#copy config files to workdir
COPY ./package.json .

#install dependencies
RUN npm install

#copy everything else to workdir
COPY . .

#specify command to build app for production
RUN npm run build


######### RUN PHASE ###########
#specify base image for run phase
FROM nginx

#specify files to copy from build phase to run phase
COPY --from=builder /app/build /usr/share/nginx/html

## no need to specify a startup command like ["start","nginx"] when using nginx because that action is automatically executed ##