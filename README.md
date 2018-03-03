
# Deployment
Deployment is handled via the `capistrano` gem.
This command deploys the master branch to the production server:
```
$ cap production deploy
```
> The current configuration deploys the development branch.
  This will be changed upon releasing the first live build.

# Bugs & Fixes
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