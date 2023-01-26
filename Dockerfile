# Specify Node Version and Image
# Name Image development (can be anything)
FROM node:18 AS development

# Specify Working directory inside container
WORKDIR /src/app

# Copy package-lock.json & package.json from host to inside container working directory
COPY package*.json ./

# Install deps inside container
RUN npm install

RUN npm run build

EXPOSE 3000

################
## PRODUCTION ##
################
# Build another image named production
FROM node:18 AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Set work dir
WORKDIR /src/app

COPY --from=development /src/app/ .

EXPOSE 3000

# run app
CMD [ "node", "dist/main"]