# frozen_string_literal: true

class MakeRequestsController < ApplicationController
  def index
    sleep (0..120).to_a.sample / 1000.0
  end
end
