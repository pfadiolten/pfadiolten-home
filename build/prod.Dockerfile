FROM ruby:2.6.6-alpine3.12 as builder

ENV BUNDLER_VERSION=2.1.4
ENV RAILS_ENV=development
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

RUN chmod +x bin/*                   \
 && gem install bundler:2.1.4        \
 && bundle install                   \
      --jobs "$(nproc)"              \
      --without development test     \
 && yarn install --pure-lockfile     \
 && rails assets:precompile


FROM ruby:2.6.6-alpine3.12

ENV BUNDLER_VERSION=2.1.4
ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN apk --update --no-cache add \
    libpq                       \
    tzdata                      \
    imagemagick file

WORKDIR /app
COPY . .
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/public/assets /app/public/assets
COPY --from=builder /app/public/packs /app/public/packs

RUN chmod +x bin/*                   \

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

