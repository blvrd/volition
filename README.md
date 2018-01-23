# Volition

Build status: [![CircleCI](https://circleci.com/gh/garrettqmartin8/volition.svg?style=svg&circle-token=f883f7406ee9df386967c67b4a6f5a330083fe29)](https://circleci.com/gh/garrettqmartin8/volition)

## Self hosting HEROKU   
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/garrettqmartin8/volition)

Volition is designed with self hosting in mind. By using “Deploy to Heroku” button above, you can be up and running in a few minutes!

To update your deployed app with the lastest changes:

1. Clone this repo: `git clone git@github.com:garrettqmartin8/volition.git`
2. Run `bin/update_heroku` from the command line.
3. Enjoy your updated app!

## Self hosting Ubuntu

Volition runs great on Ubuntu Server. Tested on Ubuntu 14.04 (YMMV)

### Prerequisites for Ubuntu install:

1. Ruby 2.4.0 (install using rvm)
- _make sure rvm installed:_
- `sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev`
- `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
- `\curl -sSL https://get.rvm.io | bash -s stable`
- `source ~/.rvm/scripts/rvm`
- _then install pre-stuff for ruby:_   
- `sudo apt-add-repository ppa:brightbox/ruby-ng`
- `sudo apt-get update`
- `sudo apt-get install libpq-dev git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs`
- `rvm install 2.4.0`
- `rvm use 2.4.0 --default`
- `ruby -v`_should be 2.4.0_

2. PostgreSQL
- `sudo apt-get update`
- `sudo apt-get install postgresql postgresql-contrib`
- edit the postgres config to trust local user connections by default
- `sudo nano /etc/postgresql/9.3/main/pg_hba.conf`
- edit the lines for local to be trust instead of peer or md5:   
```
# Database administrative login by Unix domain socket
local   all             postgres                                trust

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
```
### Post setup of Ruby & Postgres on Ubuntu Server

You can try just running ./bin/setup at this point as mentioned at the bottom of this readme, but I found I had to work through the following three gotchas before anything worked.

1. Edit config/database.yml and add in `username: postgres` and `password:` fields for development and production sections
2. install bundler gem: `gem install bundler`
3. config bundler to get `pg` to install properly: `bundle config build.pg --with-pg-lib="/var/lib/postgresql/9.3/main"`

### Run on local port 3000 on Ubuntu

Simply `rails -s`

You can run this in `tmux` or daemonize this process using `passenger` or `systemd`

### setup with NGINX reverse proxy

create a new NGINX vhost file in /etc/nginx/sites-available/, for example /etc/nginx/sites-available/volition

here is example volition file:

```
server {
    server_name do.jamescampbell.us;
    listen 80;

    access_log /var/log/nginx/do-access.log;
    error_log /var/log/nginx/do-error.log;

    location / {
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   Host      $host;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
        proxy_pass         http://127.0.0.1:3000;
    }
 
}
```

and go to what you set in your server\_name field and it should just work


## Contributing

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

PRs are welcome!

MIT License

