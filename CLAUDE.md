# CLAUDE.md

## Commits / PRs

- Write commit messages in English, both subject and body (consistent with the existing history)
- Write PR titles and descriptions in English

## Code

- Write code comments in English (consistent with the existing code)

## Development

- Development and tests run on Docker: `docker compose up -d db` -> `docker compose build app` -> `docker compose run --rm app bin/rails test`
- The schema is managed with db/structure.sql (postfixadmin database version 1841), not with migrations
- Initialize the development DB with `bin/rails db:create db:structure:load db:seed` (seeded login: admin@example.com / adminpass)
- Note that `db:structure:load` loads into both development and test, so it fails with duplicate errors when the test DB is already loaded
