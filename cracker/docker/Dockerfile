# Create a Java runtime
FROM eclipse-temurin:19 as jre-build

RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base,java.logging,java.net.http \
         --strip-debug \
         --strip-java-debug-attributes \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# Install Extism
FROM debian:stable-slim as extism-install

RUN apt-get update -y
RUN apt-get install git -y
RUN apt install -y pkg-config
RUN apt install python3-pip -y
RUN pip3 install poetry
RUN pip3 install git+https://github.com/extism/cli

ENV EXTISM_HOME="${HOME}/.local"
ENV PATH "${EXTISM_HOME}/bin:${PATH}"

RUN extism install latest

# Create wasm runner image
FROM debian:buster-slim

ENV CRACKER_VERSION="0.0.3"
ENV LD_LIBRARY_PATH="/usr/local/lib"

COPY --from=extism-install /usr/local/lib/libextism.so /usr/local/lib/libextism.so
COPY --from=extism-install /usr/local/include/extism.h /usr/local/include/extism.h

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# Continue with your application deployment
RUN mkdir /opt/app
RUN mkdir /opt/app/tmp
COPY cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar /opt/app/cracker.jar

CMD ["java", "-jar", "/opt/app/cracker.jar"]
