FROM ruby:2.5.1-alpine3.7

RUN apk add --update \
    build-base \
    git \
    linux-headers \
    postgresql-dev \
    nodejs \
    tzdata

WORKDIR /pfadiolten-home
COPY Gemfile      .
COPY Gemfile.lock .

#RUN gem update bundler
RUN bundle install

COPY . /pfadiolten-home