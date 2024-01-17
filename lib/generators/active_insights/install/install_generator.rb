# frozen_string_literal: true

class ActiveInsights::InstallGenerator < Rails::Generators::Base
  def add_route
    route "mount ActiveInsights::Engine => \"/insights\""
  end

  def create_migrations
    rails_command "active_insights:install:migrations", inline: true
  end
end
