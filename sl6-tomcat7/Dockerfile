FROM basesl6:v2
MAINTAINER Nick Boen <nboen@digitalriver.com>


# Build command for the Dockerfile
#  sudo docker build -t="sl6-tomcat7:v1" .

# Run command for the image
#  docker run -itP sl6-tomcat7:v1 /bin/bash

EXPOSE 8080

ENV TOMCAT_VERSION 7.0.56

# Add some OS tools
RUN yum install net-tools wget tar -y

# Add tomcat
RUN wget http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz && tar xzf /tmp/catalina.tar.gz -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && rm /tmp/catalina.tar.gz

# Add the tomcat users
RUN useradd -d /opt/tomcat tomcat 
RUN chown -R tomcat. /opt/tomcat 
RUN chown -R tomcat. /opt/apache-tomcat-${TOMCAT_VERSION}


# Copy over the tomcat users file
ADD tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
RUN chmod u=rw,g=rw,o=r /opt/tomcat/conf/tomcat-users.xml

# Copy over the tomcat service file
ADD tomcat7-servicescript /etc/rc.d/init.d/tomcat7
RUN chmod u=rwx,g=rx,o=rx /etc/rc.d/init.d/tomcat7

# Setup the service to start automatically
#RUN /etc/rc.d/init.d/tomcat7 start
#CMD service tomcat7 start > test.log
RUN chkconfig --add tomcat7
RUN chkconfig tomcat7 on



# Download Slashdot homepage
RUN mkdir /opt/tomcat/webapps/slashdot
RUN wget http://www.slashdot.org -P /opt/tomcat/webapps/slashdot

ADD apps.tar.gz /tmp/apps

#RUN for i in $(ls /tmp/apps/) ; do mkdir -p /opt/tomcat/webapps/${i} && cp -f /tmp/apps/${i}/* /opt/tomcat/webapps/${i}/ ; done
#RUN for i in $(ls /tmp/apps/wars/) ; do mkdir -p /opt/tomcat/webapps/${i} && cp -f /tmp/apps/wars/${i}/* /opt/tomcat/webapps/${i}/ ; done

#RUN for i in $(ls /tmp/apps/wars/) ; do echo ${i} && mv /tmp/apps/wars/${i} /opt/tomcat/webapps/${i} ; done

# Start Tomcat, after starting Tomcat the container will stop. So use a 'trick' to keep it running.
#CMD /bin/bash service tomcat7 start && tail -f /opt/tomcat/logs/catalina.out

#use ENTRYPOINT so parms can be sent in

ADD addwar.sh /opt/addwar.sh

RUN chmod +x /opt/addwar.sh
ENTRYPOINT ["/opt/addwar.sh"]

#CMD service tomcat7 start

# Start Tomcat, after starting Tomcat the container will stop. So use a 'trick' to keep it running.
#CMD /bin/bash service tomcat7 start && tail -f /opt/tomcat/logs/catalina.out
#CMD ["tail -f /opt/tomcat/logs/catalina.out"]
