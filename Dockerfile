FROM radek1st/kafka

ENV MAXWELL_VERSION 1.1.1

#RUN apt-get update && apt-get --force-yes upgrade

RUN mkdir /app

ADD producer-app.sh run.sh /app/

WORKDIR /app

RUN chmod a+x *.sh

RUN curl -sLo - https://github.com/zendesk/maxwell/releases/download/v"$MAXWELL_VERSION"/maxwell-"$MAXWELL_VERSION".tar.gz \
  | tar --strip-components=1 -zxvf -

RUN echo "$MAXWELL_VERSION" > /REVISION

CMD ./run.sh && supervisord -n
