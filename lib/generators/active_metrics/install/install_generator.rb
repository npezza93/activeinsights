# frozen_string_literal: true

class ActiveMetrics::InstallGenerator < Rails::Generators::Base
  def add_route
    route "mount ActiveMetrics::Engine => \"/metrics\""
  end

  def create_migrations
    rails_command "active_metrics:install:migrations", inline: true
  end
end
