FROM alpine:3.4
RUN apk add --no-cache python3 nodejs make bash \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install virtualenv

WORKDIR /app
RUN virtualenv /venv

ARG ENV=local

COPY package.json /app/
RUN npm install

COPY config/requirements/$ENV.txt /app/config/requirements/
RUN source /venv/bin/activate \
    && pip install -r config/requirements/$ENV.txt

COPY . /app/

RUN ls -lh
RUN source /venv/bin/activate \
    && make migrate

COPY config/django/entrypoint.sh /bin/

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 8888
CMD ["django-server"]
