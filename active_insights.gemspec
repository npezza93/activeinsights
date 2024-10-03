# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

require "active_insights/version"

Gem::Specification.new do |spec|
  spec.name        = "activeinsights"
  spec.version     = ActiveInsights::VERSION
  spec.authors     = ["Nick Pezza"]
  spec.email       = ["pezza@hey.com"]
  spec.homepage    = "https://github.com/npezza93/activeinsights"
  spec.summary     = "Rails performance tracking"
  spec.license     = "MIT"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.required_ruby_version = ">= 3.2.0"
  spec.files = Dir["{app,config,db,lib,vendor}/**/*", "LICENSE.md",
                   "Rakefile", "README.md"]

  spec.add_dependency "chartkick"
  spec.add_dependency "importmap-rails"
  spec.add_dependency "rails", ">= 7.2"
end
