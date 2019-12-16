FROM java:8
MAINTAINER George <ubuntu_vip@sina.cn>
VOLUME /tmp
ADD eureka-server.jar eureka-server.jar
#RUN bash -c 'touch /eureka-server.jar'
EXPOSE 8761
ENTRYPOINT ["java","-Xmx128m","-Djava.security.egd=file:/dev/./urandom","-jar","/eureka-server.jar"]