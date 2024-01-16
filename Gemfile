# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in active_metrics.gemspec.
gemspec

group :development, :test do
  gem "activerecord-enhancedsqlite3-adapter"
  gem "simplecov"

  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"

  gem "propshaft"
  gem "puma"

  gem "importmap-rails"
  gem "stimulus-rails"

  gem "rubystats"
end
