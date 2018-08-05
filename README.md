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
The container saves its database in an external volume.
It has to be created before first using the website:
```bash
docker volume create --name pfadiolten_home-data -d local
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
Requires a valid access token in the environment variable `PFADIOLTEN_OSM_ACCESS_TOKEN`.

#### Instagram
- **`PFADIOLTEN_INSTAGRAM_CLIENT_ID`**
- **`PFADIOLTEN_INSTAGRAM_CLIENT_SECRET`**
- **`PFADIOLTEN_INSTAGRAM_ACCESS_TOKEN`**

## Bugs & Fixes
### `devise` or `bcrypt` not found, but they are installed  
Rails or bundler may throw an error regarding either devise (eg. `class Devise not found` and similar) or bcrypt (eg. `unable to load bcrypt_ext` and similar).
The fix to this is to reinstall both gems with the explicit platform `ruby`.

1. `gem uninstall devise`
2. `gem uninstall bcrypt`
3. `gem install bcrypt --platform ruby`
4. `gem install devise --platform ruby`

It is advised to uninstall all versions of devise and bcrypt, regardless of platform or version.
The installation commands may also have to be supplied with a version tag.

Some parts of rails (migrations and others) may still not work correctly even after applying this fix.
Adding `ruby` as a valid platform for bundler should get rid of all remaining issues.

```
$ bundle lock --add-platform ruby
```