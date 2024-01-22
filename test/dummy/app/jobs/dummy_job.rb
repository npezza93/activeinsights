class DummyJob < ApplicationJob
  def perform
    sleep 1
  end
end
