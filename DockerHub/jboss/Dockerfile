FROM phusion/baseimage:0.9.16
MAINTAINER Rodrigo Parra <rodpar07@gmail.com>

# Install Java.
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y pwgen oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

WORKDIR /opt

RUN wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz && \
    tar zxf jboss-as-7.1.1.Final.tar.gz && \
    rm jboss-as-7.1.1.Final.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

ADD standalone.xml /opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml
RUN sed -i -r 's/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/' /opt/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml


ADD run.sh /opt/run.sh
ADD set_jboss_admin_pass.sh /opt/set_jboss_admin_pass.sh
ADD setup_user.sh /opt/setup_user.sh
RUN chmod 755 /opt/*.sh

# Exposed ENV
RUN /opt/setup_user.sh
ENV JBOSS_PASS **Random**
ENV JBOSS_HOME /opt/jboss-as-7.1.1.Final


RUN mkdir -p $JBOSS_HOME/modules/org/postgresql/main
WORKDIR $JBOSS_HOME/modules/org/postgresql/main
RUN wget https://jdbc.postgresql.org/download/postgresql-9.3-1103.jdbc41.jar
ADD module.xml module.xml
RUN chown -R opendata:opendata /opt

ADD deploy.sh /home/opendata/
RUN chmod 755 /home/opendata/deploy.sh
RUN chown opendata:opendata /home/opendata/deploy.sh

USER opendata
WORKDIR /home/opendata/app

WORKDIR /

CMD ["/opt/run.sh"]
