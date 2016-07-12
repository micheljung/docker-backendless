FROM debian:jessie
MAINTAINER michel@micheljung.ch

RUN apt-get update && \
    apt-get install -y \
        wget 

ARG FIRST_NAME=
ARG LAST_NAME=
ARG EMAIL_ADDRESS=
ARG PASSWORD=1234
ARG SMTP_USERNAME=test
ARG SMTP_PASSWORD=1234
ARG SMTP_HOST=smtp.example.com
ARG SMTP_PORT=
ARG SMTP_CONNECTION=
ARG APP_NAME=
ARG HOST_NAME=

RUN if [ -z "${HOST_NAME}" ]; then echo >&2 'error: You need to specify --build-arg HOST_NAME='; exit 1; fi
        
RUN wget https://downloads.bitnami.com/files/stacks/backendless/3.0.0-24/backendless-3.0.0-24-linux-x64-installer.run -O installer.run

RUN chmod +x installer.run
RUN echo "/opt/backendless\n\
${FIRST_NAME}\n\
${LAST_NAME}\n\
${EMAIL_ADDRESS}\n\
${PASSWORD}\n\
${PASSWORD}\n\
y\n\
2\n\
${SMTP_USERNAME}\n\
${SMTP_PASSWORD}\n\
${SMTP_PASSWORD}\n\
${SMTP_HOST}\n\
${SMTP_PORT}\n\
${SMTP_CONNECTION}\n\
${APP_NAME}\n\
${HOST_NAME}\n\
y\n\
n\n" | ./installer.run

VOLUME /opt/backendless

RUN rm installer.run

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 80