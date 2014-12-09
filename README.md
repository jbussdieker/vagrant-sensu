vagrant-sensu
=============

## Usage

Install puppet modules

    bundle install
    bundle exec librarian-puppet install

Run everything on one host:

    vagrant up aio

Run each component on separate hosts:

    vagrant up queue redis server api dashboard

The dashboard can be found at http://localhost:3000 unless the port was already in use in which case the logs will reveal what the port was remapped to.
