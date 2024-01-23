# frozen_string_literal: true

module ActiveInsights
  class Job < ::ActiveInsights::Record
    def self.setup(started, finished, unique_id, payload)
      create!(started_at: started, finished_at: finished, uuid: unique_id,
              db_runtime: payload[:db_runtime], job: payload[:job].class.to_s,
              queue: payload[:job].queue_name,
              scheduled_at: payload[:job].scheduled_at)
    end

    before_validation do
      self.queue_time ||=
        if scheduled_at.blank?
          0.0
        else
          (started_at - scheduled_at) * 1000.0
        end
    end
  end
end
