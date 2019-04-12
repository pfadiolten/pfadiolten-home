# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Add `events/index` as a dynamic (client side) calendar view.

### Changed
- Authentication is now delegated to our NextCloud server (https://cloud.pfadiolten.ch).
- Revamping `Event` model and views.
  Migrating old records to new table.
- Cleaning up/Standardizing model classes
  
### Removed
- Cleanup of some unnecessary files