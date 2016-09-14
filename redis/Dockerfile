FROM redis:alpine

RUN true && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
        entr

COPY root /

ENTRYPOINT ["entrypoint.sh"]
CMD ["watcher"]
