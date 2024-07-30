# Maincast Calendar

- [Description](#description)
- [Setup](#setup)
- [Links](#links)
- [Environment Variables](#environment-variables)

## Description

**Maincast Calendar** is a robust application designed for efficient planning and management of events and personnel.
The primary features include:

- **Broadcast Schedule Planning**: Seamlessly plan and organize your broadcast schedules.
- **Personnel Coordination**: Efficiently involve and manage personnel for broadcasts and events.
- **Workload Management**: Effectively oversee staff and studio workloads.

This repository hosts the backend component of the Maincast Calendar application. It is integrated with the frontend
part, which can be found
at [broadcast-shift-calendar-front](https://github.com/masterwebcompany/broadcast-shift-calendar-front).

The deployment process for this application is managed through Docker, with detailed instructions available in
the [broadcast-shift-calendar-docker](https://github.com/masterwebcompany/broadcast-shift-calendar-docker) repository.

## Setup

### Setup rails in docker on http://localhost:3000:

```
git clone -b dev https://github.com/masterwebcompany/broadcast-shift-calendar-api.git
cd ./broadcast-shift-calendar-api
cp .env.example .env
make setup
```

### Start front in docker on http://localhost:9000:

```
git clone -b dev https://github.com/masterwebcompany/broadcast-shift-calendar-front.git
cd ./broadcast-shift-calendar-front
cp .env.example .env
make start
```

### Start both rails and front in docker on http://localhost:9000 and http://localhost:3000:

```
cd ./broadcast-shift-calendar-api
make full-app-start
```

### Setup rails:

Install gems: `bundle install`

Create database: `rails db:create`

Migrate database: `rails db:migrate` or `rails db:schema:load`

Seed database: `rails db:seed`

Start rails: `rails s`

### Setup postgresql (MacOS):

Install postgresql: `brew install postgresql@16`

Include postgresql binary: `echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.bash_profile`

Apply the changes to current shell session: `source ~/.bash_profile`

Start postgresql: `brew services start postgresql@16`

Stop postgresql: `brew services stop postgresql@16`

### Setup redis (MacOS):

Install redis: `brew install redis`

Start redis: `brew services start redis`

Stop redis: `brew services stop redis`

## Links

- [Production](https://crm.maincast.com)
- [Development](https://next-crm.maincast.com)
- [Deployment](https://maincast.atlassian.net/wiki/spaces/MaincastCa/pages/690814977/Deployment)

## Tech Stack

- [Ruby](https://www.ruby-lang.org/en) – Language
- [Ruby on Rails](https://rubyonrails.org/) – Framework for building web application (backend)
- [Rspec](https://rspec.info/) - Framework for writing specs
- [Postgresql](https://www.postgresql.org/) - Database
- [Redis](https://redis.io/) - Redis, for caching common data
- [Devise](https://github.com/heartcombo/devise) - Flexible authentication solution for Rails
- [Telegram-Bot](https://github.com/telegram-bot-rb/telegram-bot) - Telegram Bot client, to integrate bot into rails application
- [Discordrb](https://github.com/shardlab/discordrb) - Discord Bot client, to integrate bot into rails application
- [Rswag](https://github.com/rswag/rswag) - Library for API DOCS
- [Rubocop](https://github.com/rubocop/rubocop) - Ruby code linter
- [Brakeman](https://brakemanscanner.org/) - Vulnerability scanner specifically designed for Ruby on Rails applications.
- [Docker](https://www.docker.com/) – Virtual Machine Platforms & Containers

## Environment Variables

To run this project, you will need to add the following environment variables to your [.env.example](https://github.com/masterwebcompany/broadcast-shift-calendar-api/blob/BC-472/.env.example) file:
