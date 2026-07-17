# CLAUDE.md

## Commits / PRs

- Write commit messages in English, both subject and body (consistent with the existing history)
- Write PR titles and descriptions in English

## Code

- Write code comments in English (consistent with the existing code)

## Development

- Development and tests run on Docker: `docker compose up -d db` -> `docker compose build app` -> `docker compose run --rm app bin/rails test`
- The schema is managed with db/structure.sql (postfixadmin database version 1841), not with migrations
- Initialize the development DB with `bin/rails db:create db:schema:load db:seed` (seeded login: admin@example.com / adminpass)
- `db:schema:load` only loads the development DB; the test DB is prepared separately with `bin/rails db:test:prepare`
