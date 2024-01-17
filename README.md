# ActiveMetrics
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "activemetrics"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install activemetrics
```

And then install migrations:
```bash
bin/rails active_metrics:install
bin/rails rails db:migrate
```

This also mounts a route in your routes file to view the metrics at `/metrics`.


##### Config

You can supply a hash of connection options to `connects_to` set the connection
options for the `Request` model.

```ruby
ActiveMetrics.connects_to = { database: { writing: :requests, reading: :requests } }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rails test` to run the unit tests.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, execute `bin/publish (major|minor|patch)` which will
update the version number in `version.rb`, create a git tag for the version,
push git commits and tags, and push the `.gem` file to GitHub.

## Contributing

Bug reports and pull requests are welcome on
[GitHub](https://github.com/npezza93/activemetrics). This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
