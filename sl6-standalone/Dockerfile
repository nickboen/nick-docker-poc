FROM basesl6:v2
MAINTAINER Nick Boen <nboen@digitalriver.com>


# Build command for the Dockerfile
#  sudo docker build -t="sl6-standalone:v1" .

# Run command for the image
#  docker run -itP sl6-standalone:v1 /bin/bash

EXPOSE 9000

# Add some OS tools
RUN yum install net-tools wget -y

RUN mkdir /opt/serviceapp

# Add the tomcat users
RUN useradd -d /opt/serviceapp serviceuser 
RUN chown -R serviceuser. /opt/serviceapp 


ADD entrypoint.sh /opt/entrypoint.sh

RUN chmod +x /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]

