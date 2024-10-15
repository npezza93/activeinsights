# frozen_string_literal: true

class AddIpAddressToRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :active_insights_requests, :ip_address, :string
  end
end
