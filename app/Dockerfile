FROM alpine:edge

COPY package.json /
RUN true \
    && apk add --no-cache \
           nodejs \
    && npm install

COPY requirements.txt /
RUN true \
    && apk add --no-cache \
           python3 \
           uwsgi \
           uwsgi-python3 \
           libldap \
           libpq \
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

RUN true \
    && apk add --no-cache \
           netcat-openbsd

COPY uwsgi.ini /etc/
COPY entrypoint.sh /bin/
COPY webpack.config.js /
COPY bootstrap.config.js /
COPY bootstrap.config.less /
COPY server.js /

COPY manage.py /

ENTRYPOINT ["entrypoint.sh"]
CMD []
