# frozen_string_literal: true

module ActiveInsights
  class Request < ::ActiveInsights::Record
    def self.setup(started, finished, unique_id, payload)
      req = payload[:request]

      create!(started_at: started, ip_address: req.remote_ip,
              finished_at: finished, uuid: unique_id,
              http_method: payload[:method], user_agent: req.user_agent,
              **payload.slice(:controller, :action, :format, :status,
                              :view_runtime, :db_runtime, :path))
    end

    def percentage(others)
      (agony / others.sum(&:agony)) * 100.0
    end
  end
end
