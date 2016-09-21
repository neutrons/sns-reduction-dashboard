## Postges


Edit the following file:

```bash
# Ubuntu:
sudo vi /etc/postgresql/9.3/main/pg_hba.conf
# Redhat:
sudo vi /var/lib/pgsql/9.4/data/pg_hba.conf
```
Replace all *peer* or *ident* at the end by *md5*:

E.g.:
```
# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
```
by
```
# "local" is for Unix domain socket connections only
local   all             all                                     ident
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
```

Note:
To access the database through the command line (i.e. `psql`) we need to use `ident`.
From django we need `md5`. **Need to confirm this!**.

Restart postgres:

```
# Ubuntu
sudo service postgresql restart
# Redhat
sudo systemctl restart postgresql-9.4
```

#### Test:

```
sudo su - postgres
psql

```

#### Create database

Configure Postgres:  

```bash
# Enter as postgres user
sudo su - postgres

# Database and username/password is available in the ```.env``` file
# that should have been provided separately.

# Create user sns_dashboard
#
createuser -P -s -e sns_dashboard

# Once postgres user, create a db
createdb -O sns_dashboard -W sns_dashboard
```

#### Test

Test the database. This should work:

*Note*:

To use user/pass the settings above must be in *md5*!

```
psql --username=sns_dashboard -W sns_dashboard
# list all databases
\list
# Connect to database:
\connect sns_dashboard
# list all tables in the current database
\dt
```

#### Usefull


Delete all tables owened by a user:

```
drop owned by reduction;
```
