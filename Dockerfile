FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /pfadiolten-home
WORKDIR /pfadiolten-home
COPY Gemfile /pfadiolten-home/Gemfile
COPY Gemfile.lock /pfadiolten-home/Gemfile.lock

RUN gem update bundler
RUN bundle install

COPY . /pfadiolten-home