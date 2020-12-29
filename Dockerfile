FROM ruby:2.5.3-alpine3.8

ENV APP_HOME="/app" \
    GEMS="/usr/local/bundle" \
    ENTRY_POINT_DIR="docker-entrypoint-init.d" \
    DEV_PACKAGES="yaml nodejs-npm curl jq zlib-dev libxml2-dev libffi-dev libxslt-dev postgresql-dev tzdata yaml-dev libstdc++ bash ca-certificates mariadb mariadb-client mariadb-dev git" \
    BUILD_PACKAGES="build-base libressl-dev libc-dev linux-headers"

RUN apk update && apk --update add $DEV_PACKAGES

ADD Gemfile $GEMS/
ADD Gemfile.lock $GEMS/
WORKDIR $GEMS

RUN apk update && \
    apk --update add --no-cache --virtual build-dependencies $BUILD_PACKAGES && \
    gem install bundler && \
    bundle install --jobs=4 && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

EXPOSE 3000

RUN rm -f tmp/pids/server.pid
CMD ["rails", "s", "-p", "3000", "-b", "0.0.0.0"]
