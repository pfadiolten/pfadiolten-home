# [pfadiolten.ch](https://pfadiolten.ch)

## Deployment
Deployment is handled via the `capistrano` gem.
This command deploys the master branch to the production server:
```bash
cap production deploy
```

### Staging
The staging server can be found at [dev.pfadiolten.ch](https://dev.pfadiolten.ch).
Deploy to it with the `staging` stage.
```bash
cap staging deploy
```

## Development
Development is usually done in a [docker](https://www.docker.com) container.
Use the container with the following commands:
```bash
# (re)build the image
docker-compose build

# start the server
docker-compose up

# start the server in the background
docker-compose up -d
```
In development, Gems are mounted in a local docker volume.
This makes it possible to just run a single command when modifying 
the `Gemfile`, instead of rebuilding the complete image.
```bash
# create the gem volume, only required once
docker volume create pfadiolten-home.gems

docker-compose run web bundle
```
This always has to be done before running the container for the first time.

The container saves its database in an external volume.
It has to be created before first using the website:
```bash
docker volume create pfadiolten-home.data
``` 
Afterwards, the database has to be created and migrated.
```bash
docker-compose run web rails db:create db:migrate
```
Migrations on an existing database don't require the `db:create` part.
```bash
docker-compose run web rails db:migrate
```
Afterwards, the API should be available at `localhost:3000`.

### API Keys
The application requires access to a couple of APIs.
Their respective access information can either be set with private credentials,
or be copied from the deployment server.

#### OpenStreetMap
- `PFADIOLTEN_OSM_ACCESS_TOKEN`

#### Instagram
- `PFADIOLTEN_INSTAGRAM_CLIENT_ID`
- `PFADIOLTEN_INSTAGRAM_CLIENT_SECRET`
- `PFADIOLTEN_INSTAGRAM_ACCESS_TOKEN`