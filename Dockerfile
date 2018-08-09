FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /pfadiolten-home
COPY Gemfile      /pfadiolten-home/Gemfile
COPY Gemfile.lock /pfadiolten-home/Gemfile.lock

#RUN gem update bundler
RUN bundle install

COPY . /pfadiolten-home