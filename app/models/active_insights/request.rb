# frozen_string_literal: true

module ActiveInsights
  class Request < ::ActiveInsights::Record
    def self.setup(started, finished, unique_id, payload)
      create!(started_at: started, finished_at: finished, uuid: unique_id,
              http_method: payload[:method], **payload.slice(
                :controller, :action, :format, :status, :view_runtime,
                :db_runtime
      ))
    end
  end
end
