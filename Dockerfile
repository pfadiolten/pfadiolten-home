FROM ruby:2.5.1-alpine3.7

RUN apk --update add    \
    build-base          \
    git                 \
    linux-headers       \
    postgresql-dev      \
    nodejs              \
    tzdata              \
    imagemagick file

WORKDIR /pfadiolten-home
COPY Gemfile      .
COPY Gemfile.lock .

#RUN gem update bundler
RUN bundle install

COPY . /pfadiolten-home