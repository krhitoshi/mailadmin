# MailAdmin

A web admin panel for a Postfix/Dovecot mail server backed by a
postfixadmin-style database (database version 1841). GUI counterpart of
[postfix_admin](https://github.com/krhitoshi/postfix_admin).

## Development

Development and tests run on Docker:

```
docker compose up -d db
docker compose build app
docker compose run --rm app bin/rails db:create db:structure:load db:seed
docker compose run --rm app bin/rails test
docker compose up app   # http://localhost:3000 (admin@example.com / adminpass)
```

The schema is managed with `db/structure.sql`, not with migrations.

## Production

`secret_key_base` is required in production. This repository does not ship
`config/credentials.yml.enc`; each deployment generates its own credentials
once:

```
EDITOR=vi bin/rails credentials:edit
```

This creates `config/master.key` and `config/credentials.yml.enc` with a
fresh `secret_key_base` (both are gitignored). Keep `config/master.key`
secret and out of version control.

Alternatively, set the `SECRET_KEY_BASE` environment variable
(e.g. for Docker deployments), which takes precedence over credentials:

```
SECRET_KEY_BASE=$(bin/rails secret)
```

The database password is supplied with the `MAILADMIN_DATABASE_PASSWORD`
environment variable (see `config/database.yml`).
