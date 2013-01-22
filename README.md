# Restaurant Week Map

You should only be editing files in:
* assets
* data
* haml
* sass
* coffee
* fonts

## Development

Run `gem install bundler && bundle` to install necessary gems.

Run `ruby server.rb` to run a server.

Run `watchr compile.watchr` to auto-compile assets during development.

Run `rake compile` once, since watchr won't pick up changes when it starts up.

## Deployment

Run `rake compile` to compile all the assets for static deployment.

Push to GitHub pages (make sure you're pusing the `gh-pages` branch)
