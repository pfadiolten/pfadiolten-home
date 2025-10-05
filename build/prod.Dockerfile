FROM ruby:2.7.8-alpine3.16 AS builder

ENV BUNDLER_VERSION=2.3.7
ENV RAILS_ENV=production
ENV NODE_ENV=development

RUN apk --update --no-cache add \
    build-base          \
    git                 \
    linux-headers       \
    postgresql-dev      \
    nodejs yarn         \
    tzdata

WORKDIR /app
COPY . .

RUN chmod +x bin/*                         \
 && gem install bundler:${BUNDLER_VERSION} \
 && bundle install                         \
      --jobs "$(nproc)"                    \
      --without development test           \
 && yarn install --pure-lockfile           \
 && SECRET_KEY_BASE="123" rails assets:precompile


FROM ruby:2.7.8-alpine3.16

ENV BUNDLER_VERSION=2.3.7
ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN apk --update --no-cache add \
    libpq                       \
    nodejs                      \
    tzdata                      \
    imagemagick file

WORKDIR /app
COPY . .
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/public/ /app/public/

RUN dos2unix bin/rails && chmod +x bin/*

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

