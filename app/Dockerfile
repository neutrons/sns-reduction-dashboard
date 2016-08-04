FROM alpine:edge

RUN true \
    && apk add --no-cache \
           python3 \
           uwsgi \
           uwsgi-python3 \
           libldap \
           libpq \
           netcat-openbsd

COPY requirements.txt /
RUN true \
    && apk add --no-cache --virtual build-dependencies \
           build-base \
           gcc \
           linux-headers \
           linux-headers \
           openldap-dev \
           postgresql-dev \
           python3-dev \
    && python3 -m pip install --upgrade \
               pip \
    && python3 -m pip install -r /requirements.txt \
    && apk del build-dependencies

COPY root /

WORKDIR /usr/src

ENV PYTHONPATH=/usr/src

ENTRYPOINT ["entrypoint.sh"]
CMD ["watcher"]
