# frozen_string_literal: true

desc "Copy over the migrations and mount route for ActiveInsights"
namespace :active_insights do
  task install: :environment do
    Rails::Command.invoke :generate, ["active_insights:install"]
  end
end
