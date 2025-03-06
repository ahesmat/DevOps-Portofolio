# Specify base image
FROM alpine

# Install some dependencies
RUN apk add npm

# Change work directory inside the image
WORKDIR /app

# Copy the package.json file inside the image

COPY package.json .
COPY index.js .

# Install Dependencies

RUN npm install

# Default Command

CMD ["npm","start"]
