# README (broadcast-shift-calendar-api)

## Set up postgres DB (MacOS):

Install postgresql: `brew install postgresql`

Include the PostgreSQL binary in your PATH variable in order to access the PostgreSQL
command line tools:

`echo 'export PATH="/usr/local/opt/postgresql/bin:$PATH"' >> ~/.bash_profile`

Apply the changes you made to your ~/.bash_profile file to your current shell session:

`source ~/.bash_profile`
To start the service and enable it to start at login, run the following: `brew services start postgresql`

Check to make sure the installation was successful: `postgres -V`

Output: `postgres (PostgreSQL) version`

## Set up Rails application:

Install gems: `bundle install`

Create DB: `rails db:create`

Migrate DB: `rails db:migrate` or `rails db:schema:load`

Seed DB: `rails db:seed`

Start application: `rails s`

## Access to stage server:

Heroku CLI

## Access to stage DB:

Heroku CLI

## Background processing:

```
> sidekiq
```

## GIT Flow:

### Requirements to GIT naming:

Just adhere to exists conventions :)

### Create feature-branch:

```
> git checkout staging
> git pull origin staging
> git checkout -b feature/name-of-feature
```

### Generate API docs:

Do not forget to regenerate API docs in case if you updated integration tests:



To keep the API documentation up-to-date.

### Be sure that next checks pass successfully:

1. Tests: `bundle exec rspec`

2. Rubocop checks (with autocorrection): `bundle exec rubocop -a`

3. Brakeman: `bundle exec brakeman -z -q`

### Commit your changes:

```
> git add .
> git commit -m 'commit message'
```

### Push your feature-branch:

```
> git push origin feature/name-of-feature
```

Then create PR to `staging/main` and merge it!

P.S.: `main` branch only for stable releases.
