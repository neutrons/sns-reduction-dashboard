FROM nginx:alpine

COPY bin/ /usr/local/bin/
COPY conf.d/ /etc/nginx/conf.d/
RUN touch /reload

ENV HOME /www
WORKDIR $HOME
COPY www/ ./

ENTRYPOINT ["entrypoint.sh"]
CMD ["watcher"]
