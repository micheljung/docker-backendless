FROM ubuntu:14.04
MAINTAINER michel@micheljung.ch

RUN apt-get update && \
    apt-get install -y \
        wget

ENV FIRST_NAME=
ENV LAST_NAME=
ENV EMAIL_ADDRESS=
ENV PASSWORD 1234
ENV SMTP_USERNAME test
ENV SMTP_PASSWORD 1234
ENV SMTP_HOST smtp.example.com
ENV SMTP_PORT=
ENV SMTP_CONNECTION=
ENV APP_NAME=
ENV HOST_NAME=
        
RUN wget https://downloads.bitnami.com/files/stacks/backendless/3.0.0-24/backendless-3.0.0-24-linux-x64-installer.run

RUN chmod +x backendless-3.0.0-24-linux-x64-installer.run
RUN echo "\n\
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
y\n" | ./backendless-3.0.0-24-linux-x64-installer.run

EXPOSE 8080
CMD ["wait", "$!"]
