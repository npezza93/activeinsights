# frozen_string_literal: true

class DummyJob < ApplicationJob
  def perform
    sleep 1
  end
end
