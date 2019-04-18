FROM ruby:2.6-alpine

RUN apk --update add    \
    build-base          \
    git                 \
    linux-headers       \
    postgresql-dev      \
    nodejs yarn         \
    tzdata              \
    imagemagick file    \
    curl-dev

WORKDIR /pfadiolten-home
COPY Gemfile      .
COPY Gemfile.lock .
COPY package.json .
COPY yarn.lock    .

RUN if [ "$http_proxy" != "" ]; then \
      gem install --clear-sources --source http://rubygems.org bundler \
      && yarn config set proxy $http_proxy                             \
    ; fi \
    && bundle install --quiet --jobs 4        \
    && yarn install --silent --pure-lockfile

COPY . /pfadiolten-home