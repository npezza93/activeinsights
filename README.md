# ActiveInsights

One of the fundemental tools needed when taking your Rails app to production is
a way to track response times. Unfortunately, theres no free, easy,
open source way to track them for small or medium apps. Skylight, Honeybadger,
Sentry, AppSignal, etc. are great, but they are are closed source and
there should be an easy open source alternative where you control the data.

ActiveInsights hooks into the ActiveSupport [instrumention](https://guides.rubyonrails.org/active_support_instrumentation.html#)
baked directly into Rails. ActiveInsights tracks RPM, RPM per controller, and
p50/p95/p99 response times and charts all those by the minute. It also tracks
jobs per minute, their duration, and latency.

![screenshot 1](https://github.com/npezza93/activeinsights/blob/main/.github/screenshot1.png)
![screenshot 2](https://github.com/npezza93/activeinsights/blob/main/.github/screenshot2.png)
![screenshot 3](https://github.com/npezza93/activeinsights/blob/main/.github/screenshot3.png)
![screenshot 4](https://github.com/npezza93/activeinsights/blob/main/.github/screenshot4.png)
![screenshot 5](https://github.com/npezza93/activeinsights/blob/main/.github/screenshot5.png)

## Installation
Add this line to your application's Gemfile:

```ruby
gem "activeinsights"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install activeinsights
```

And then install migrations:
```bash
bin/rails g active_insights:install
bin/rails rails db:migrate
```

This also mounts a route in your routes file to view the insights at `/insights`.


##### Config

You can supply a hash of connection options to `connects_to` set the connection
options for the `Request` model.

```ruby
config.active_insights.connects_to = { database: { writing: :requests, reading: :requests } }
```

You can supply an array of ignored endpoints

```ruby
config.active_insights.ignored_endpoints = ["Rails::HealthController#show"]
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
[GitHub](https://github.com/npezza93/activeinsights). This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
