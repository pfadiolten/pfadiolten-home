FROM ruby:2.5.1-alpine3.7

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

#RUN gem update bundler
RUN gem install --clear-sources --source http://rubygems.org bundler
#RUN bundle install --quiet --jobs 4

RUN yarn config set proxy $http_proxy
#RUN yarn install --silent --pure-lockfile

COPY . /pfadiolten-home