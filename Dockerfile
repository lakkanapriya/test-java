FROM ubuntu:22.04 as base
SHELL ["/usr/bin/bash", "-c"]
RUN DEBIAN_FRONTEND=noninteractive \
  apt update \
  && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive \
  curl -s "https://get.sdkman.io" | /usr/bin/bash \
  && source .sdkman/bin/sdkman-init.sh \
  && sdk install java 17.0.10-amzn

#FROM base as build
#RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends git
#RUN DEBIAN_FRONTEND=noninteractive \
#  sdk install maven 3.9.6 \
#  && sdk install springboot 3.2.2
#RUN git clone --branch main --single-branch https://github.com/lakkanapriya/test-java.git

#FROM base
#mkdir bin
#COPY --from=build staging/tdd-supermarket-1.0.0-SNAPSHOT.jar /bin/tdd-supermarket-1.0.0-SNAPSHOT.jar
COPY target/tdd-supermarket-1.0.0-SNAPSHOT.jar .
#CMD ["java -jar ./bin/tdd-supermarket-1.0.0-SNAPSHOT.jar"]
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "./tdd-supermarket-1.0.0-SNAPSHOT.jar"]
