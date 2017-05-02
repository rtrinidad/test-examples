FROM postgres:9.3
MAINTAINER Rodrigo Parra <rodpar07@gmail.com>

ENV DB_NAME sfp
ENV DB_USER admin
ENV DB_PASS password
RUN apt-get update && apt-get install -y wget && wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
RUN apt-get update && apt-get install -y postgresql-9.3-postgis-2.1 -f
ADD setup-database.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setup-database.sh
