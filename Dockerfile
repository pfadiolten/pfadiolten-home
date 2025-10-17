FROM ruby:2.7.8-alpine3.16

ENV BUNDLER_VERSION=2.1.4

RUN apk --update --no-cache add \
    build-base          \
    git                 \
    linux-headers       \
    postgresql-dev      \
    nodejs yarn         \
    tzdata              \
    imagemagick file

WORKDIR /pfadiolten-home
COPY Gemfile      .
COPY Gemfile.lock .
COPY package.json .
COPY yarn.lock    .

RUN gem update bundler
#RUN gem install --clear-sources --source http://rubygems.org bundler
# RUN bundle install --quiet --jobs 4

#RUN yarn config set proxy $http_proxy
RUN yarn install --silent --pure-lockfile

COPY . /pfadiolten-home