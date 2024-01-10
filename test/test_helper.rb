# frozen_string_literal: true

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

if ENV["COV"]
  require "simplecov"
  SimpleCov.start do
    enable_coverage :branch
    track_files "{app,lib}/**/*.rb"
    add_filter "/test/"
    add_group "Controllers", "app/controllers"
    add_group "Models", "app/models"
    add_group "Lib", "lib"
  end
end

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths =
  [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths <<
  File.expand_path("../db/migrate", __dir__)
require "rails/test_help"
Rails.application.eager_load!

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_paths =
    [File.expand_path("fixtures", __dir__)]
  ActionDispatch::IntegrationTest.fixture_paths =
    ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path =
    "#{ActiveSupport::TestCase.fixture_paths.first}/files"
  ActiveSupport::TestCase.fixtures :all
end
