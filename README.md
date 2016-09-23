# Todo app

![Build status](https://circleci.com/gh/garrettqmartin8/todo_app.svg?style=shield&circle-token=f883f7406ee9df386967c67b4a6f5a330083fe29)
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/garrettqmartin8/todo_app)

## Updating

To update your deployed app with the lastest code:

1. Clone this repo: `git clone git@github.com:garrettqmartin8/todo_app.git`
2. Run `bin/update_heroku` from the command line.
3. Enjoy your updated app!

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

### Error tracking and monitoring

Log into [AppSignal](https://appsignal.com/) and create a new app. Follow the steps they provide and run the generator. Replace the hard coded API key with `ENV['APPSIGNAL_API_KEY']`. Add the key to `.env`.

### CI

Log into [CircleCI](https://circleci.com) and create a new project that points to the Github repo.

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    $ ./bin/deploy staging
    $ ./bin/deploy production
