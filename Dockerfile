#FROM ubuntu:22.04 as base
#FROM openjdk:17-jdk-slim
FROM amazoncorretto:17-alpine3.19-jdk
#SHELL ["/usr/bin/bash", "-c"]
#RUN DEBIAN_FRONTEND=noninteractive \
#  apt update \
#  && apt install -y --no-install-recommends curl wget zip unzip \
#  && apt upgrade -y
#RUN apt-get remove ca-certificates \
#  && apt-get -y install ca-certificates \
#  && update-ca-certificates \
#  && chmod -R 755 /etc/ssl/certs \
#  && mkdir -p /etc/pki/tls/certs \
#  && cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt \
#  && export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

#RUN DEBIAN_FRONTEND=noninteractive \
#  curl -s "https://get.sdkman.io" | /usr/bin/bash \
#  && echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.bashrc \
#  && source $HOME/.sdkman/bin/sdkman-init.sh \
#  && sdk install java 17.0.10-amzn

#  curl -o sdkman.sh "https://get.sdkman.io" \
#  wget --no-check-certificate -O sdkman.sh "https://get.sdkman.io" \
#  && chmod +x sdkman.sh \
#  && ./sdkman.sh

#RUN env
#RUN find / -name \.sdkman 
#RUN source $HOME/.sdkman/bin/sdkman-init.sh

#FROM base as build
#RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends git
#RUN git clone --branch main --single-branch https://github.com/lakkanapriya/test-java.git
#RUN DEBIAN_FRONTEND=noninteractive \
#  source $HOME/.sdkman/bin/sdkman-init.sh \
#  && echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.bashrc \
#  && sdk install maven 3.9.6 \
#  && sdk install springboot 3.2.2 \
#  && pwd \
#  && ls -l /home
#RUN DEBIAN_FRONTEND=noninteractive \
#  source $HOME/.sdkman/bin/sdkman-init.sh \
#  && mvn -B clean package -Dmaven.test.skip=true --file ./pom.xml

#FROM base
#mkdir bin
#COPY --from=build staging/tdd-supermarket-1.0.0-SNAPSHOT.jar /bin/tdd-supermarket-1.0.0-SNAPSHOT.jar
#COPY ./target/tdd-supermarket-1.0.0-SNAPSHOT.jar .
COPY ./target/*.jar .
#COPY ./target/tdd-supermarket-1.0.0-SNAPSHOT-jar-with-dependencies.jar ./tdd-supermarket-1.0.0-SNAPSHOT-jar-with-dependencies.jar
#CMD ["java -jar ./tdd-supermarket-1.0.0-SNAPSHOT-jar-with-dependencies.jar"]
EXPOSE 8080
ENTRYPOINT ["java -jar /tdd-supermarket-1.0.0-SNAPSHOT.jar"]
