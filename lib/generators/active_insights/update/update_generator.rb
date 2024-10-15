# frozen_string_literal: true

class ActiveInsights::UpdateGenerator < Rails::Generators::Base
  def create_migrations
    rails_command "active_insights:install:migrations", inline: true
  end
end
