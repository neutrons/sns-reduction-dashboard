# Development

## Makefile

3 main targets:
- all
  - build 
  - up 
  - logs
- check
- clean


## Containers

See running containers:
```
$ docker ps
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS              PORTS                         NAMES
82074341dd27        snsreductiondashboard_nginx      "entrypoint.sh watche"   13 seconds ago      Up 11 seconds       0.0.0.0:80->80/tcp, 443/tcp   snsreductiondashboard_nginx_1
73d91a775215        snsreductiondashboard_api        "entrypoint.sh watche"   13 seconds ago      Up 12 seconds       80/tcp                        snsreductiondashboard_api_1
24df152592cb        snsreductiondashboard_postgres   "/sbin/entrypoint.sh"    14 seconds ago      Up 12 seconds       5432/tcp                      snsreductiondashboard_postgres_1
96b2e50cc33b        snsreductiondashboard_redis      "entrypoint.sh watche"   14 seconds ago      Up 12 seconds       6379/tcp                      snsreductiondashboard_redis_1
2993e5db4504        snsreductiondashboard_frontend   "entrypoint.sh watche"   14 seconds ago      Up 12 seconds       80/tcp                        snsreductiondashboard_frontend_1
```

stop / remove all of Docker containers:
```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

## Postges

Connect to the database:

Get the IP address:
```
docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```
Get the port:
```
docker ps -a

```
Connect:
```
psql -h <host> -p <port> -U <username> -W <password> <database>
psql -h  172.19.0.4 -p 5432 -U sns_dashboard sns_dashboard
```

