FROM node:18.8-alpine as base

FROM base as builder

WORKDIR /home/node/app

COPY package*.json ./
RUN npm ci

# Only run the copy all files command AFTER `npm ci` for better cache
COPY . .
RUN npm run build

FROM base as runtime

# Not needed at it is set by the `npm run serve` command
# ENV NODE_ENV=production

# The config path was wrong in my case, this is the correct one
ENV PAYLOAD_CONFIG_PATH=dist/payload/payload.config.js

# I set this to true when I build a new image and use it to make sure the database is set to not connect as explained on my issue
# ENV BUILD_DOCKER_IMAGE=false


WORKDIR /home/node/app
COPY package*.json  ./

RUN npm ci --omit=dev

# missing parts to copy, honestly on mine I just copy the whole repo again
COPY --from=builder /home/node/app/dist ./dist
COPY --from=builder /home/node/app/build ./build
COPY --from=builder /home/node/app/.next ./.next
COPY --from=builder /home/node/app/public ./public

# We also need next.config.js, csp.js, redirects.js ... (At least I was having issues without it) If you still have issues, I would try copying all files to the runtime image (COPY . .)
COPY *.js .


EXPOSE 3000

# This command was giving me issues
#CMD ["node", "dist/server.js"]

# I used this instead
CMD ["npm", "run", "serve"]