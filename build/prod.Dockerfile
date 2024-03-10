FROM ruby:2.6.6-alpine3.12

ENV BUNDLER_VERSION=2.1.4
ENV RAILS_ENV=production
ENV NODE_ENV=production

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

RUN gem install bundler:2.1.4             \
 && bundle install --quiet --jobs 4       \
 && yarn install --silent --pure-lockfile

COPY . /pfadiolten-home

RUN chmod +x bin/*

CMD ["bin/rails", "server", "-b", "0.0.0.0"]