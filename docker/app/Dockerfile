FROM ruby:2.7.1-alpine

ENV BUNDLER_VERSION=2.1.4

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
      postgresql-dev \
      postgresql-client \
      tzdata \
      yarn

RUN gem install bundler -v 2.1.4

ENV RAILS_ROOT /var/www/art-search
RUN mkdir -p $RAILS_ROOT
# Set working directory
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install --without test

COPY package.json package.json
COPY yarn.lock yarn.lock

RUN yarn install --check-files

COPY . .
RUN bundle exec rails webpacker:compile RAILS_ENV=production
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
