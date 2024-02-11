FROM ubuntu:22.04 as base
SHELL ["/usr/bin/bash", "-c"]
RUN DEBIAN_FRONTEND=noninteractive \
  apt update \
  && apt install -y --no-install-recommends curl wget zip unzip \
  && apt upgrade -y
RUN echo "alias curl='curl -k'" >> $HOME/.bashrc
RUN DEBIAN_FRONTEND=noninteractive \
  curl -k "https://get.sdkman.io" | /usr/bin/bash \
  && source $HOME/.sdkman/bin/sdkman-init.sh \
  && sdk install java 17.0.10-amzn

#  curl -o sdkman.sh "https://get.sdkman.io" \
#  wget --no-check-certificate -O sdkman.sh "https://get.sdkman.io" \
#  && chmod +x sdkman.sh \
#  && ./sdkman.sh

#RUN env
#RUN find / -name \.sdkman 
#RUN source $HOME/.sdkman/bin/sdkman-init.sh

FROM base as build
#RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends git
#RUN git clone --branch main --single-branch https://github.com/lakkanapriya/test-java.git
RUN DEBIAN_FRONTEND=noninteractive \
  sdk install maven 3.9.6 \
  && sdk install springboot 3.2.2
RUN mvn -B clean package -Dmaven.test.skip=true --file pom.xml

FROM base
#mkdir bin
#COPY --from=build staging/tdd-supermarket-1.0.0-SNAPSHOT.jar /bin/tdd-supermarket-1.0.0-SNAPSHOT.jar
COPY --from=build target/tdd-supermarket-1.0.0-SNAPSHOT.jar .
#CMD ["java -jar ./bin/tdd-supermarket-1.0.0-SNAPSHOT.jar"]
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "./tdd-supermarket-1.0.0-SNAPSHOT.jar"]
