# frozen_string_literal: true

class ActiveMetricsRequest < ActiveRecord::Migration[7.1]
  def change
    create_table :active_metrics_requests, if_not_exists: true do |t|
      t.string :controller
      t.string :action
      t.string :format
      t.string :http_method
      t.text :path
      t.integer :status
      t.float :view_runtime
      t.float :db_runtime
      t.datetime :started_at
      t.datetime :finished_at
      t.string :uuid
      t.float :duration

      t.timestamps
    end
  end
end
