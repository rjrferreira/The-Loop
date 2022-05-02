FROM ruby:2.5.1-alpine

ENV BUNDLER_VERSION=1.17.3

RUN gem install bundler -v 1.17.3

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      python \
      sqlite-libs \
      sqlite-dev \
      tzdata

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]