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

COPY uwsgi.ini /etc/
COPY sns_dashboard /app
COPY entrypoint.sh /bin/

ENV DEBUG off
ENV SECRET_KEY secret-key
ENV DATABASE_URL sqlite://db.sqlite3
ENV POSTGRES_PASSWORD lolk
ENV REDIS_URL redis://redis:6378/0

ENTRYPOINT ["entrypoint.sh"]
CMD ["uwsgi", "--ini", "/etc/uwsgi.ini"]
