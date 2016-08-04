FROM alpine:edge

RUN true \
    && apk add --no-cache \
           nodejs

ENV HOME /app
ENV NODE_PATH $HOME/node_modules
WORKDIR $HOME

COPY package.json ./
RUN npm install

COPY webpack.config.js ./
COPY bin/ /usr/local/bin/
COPY src ./src/
RUN touch /reload

ENTRYPOINT ["entrypoint.sh"]
CMD ["watcher"]
