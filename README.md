# Volition

Build status: [![CircleCI](https://circleci.com/gh/garrettqmartin8/volition.svg?style=svg&circle-token=f883f7406ee9df386967c67b4a6f5a330083fe29)](https://circleci.com/gh/garrettqmartin8/volition)

## Self hosting
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/garrettqmartin8/volition)

Volition is designed with self hosting in mind. By using “Deploy to Heroku” button above, you can be up and running in a few minutes!

To update your deployed app with the lastest changes:

1. Clone this repo: `git clone git@github.com:garrettqmartin8/volition.git`
2. Run `bin/update_heroku` from the command line.
3. Enjoy your updated app!

### Setting up reminders
To take advantage of the daily reflection reminders, you may need to do some extra setup:

#### SMS reminders
You’ll need to create a Twilio account and set three environment variables in the `.env` file:
- `TWILIO_SID`
- `TWILIO_AUTH_TOKEN`
- `TWILIO_SENDER_PHONE_NUMBER`

#### Email reminders
You’ll need to set some SMTP environment variables in the `.env` file:
- `SMTP_ADDRESS`
- `SMTP_DOMAIN`
- `SMTP_PASSWORD`
- `SMTP_USERNAME`

## Contributing

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

PRs are welcome!

