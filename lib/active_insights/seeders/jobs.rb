# frozen_string_literal: true

require "rubystats"

module ActiveInsights
  class JobSeeder
    def initialize(date, rpm, p50, p95, p99)
      @date = date
      @rpm = rpm
      @p50 = p50
      @p95 = p95
      @p99 = p99
    end

    def seed
      ActiveInsights::Job.insert_all(seed_attributes)
    end

    def find_percentile(sorted_data, percentile)
      sorted_data[(percentile * sorted_data.length).ceil - 1]
    end

    private

    attr_reader :date, :rpm, :p50, :p95, :p99

    def seed_attributes
      24.times.flat_map do |hour|
        60.times.flat_map do |min|
          processing_times.map { |duration| attributes(hour, min, duration) }
        end
      end
    end

    def processing_times
      Array.new(rpm) do
        p50 + (beta_distribution.rng * (p95 - p50))
      end.select { |time| time <= p99 }
    end

    def beta_distribution
      @beta_distribution ||= Rubystats::BetaDistribution.new(2, 5)
    end

    def sample_job
      %w(UserNotificationSenderJob DailyReportGeneratorJob DataCleanupWorkerJob
         InvoiceProcessingJob EmailDigestSenderJob DatabaseBackupJob
         OrderFulfillmentJob ProductCatalogUpdateJob MonthlyBillingJob
         SubscriptionRenewalCheckerJob SocialMediaPostSchedulerJob
         CustomerDataImporterJob SearchIndexRebuilderJob EventReminderSenderJob
         FileExportJob).sample
    end

    def attributes(hour, min, duration)
      started_at = date.dup.to_time.change(hour:, min:)
      job = sample_job
      queue = sample_queue(job)

      default_attributes.merge(duration:, started_at:, job:, queue:,
                               scheduled_at: started_at - sample_latency,
                               finished_at: started_at + (duration / 1000.0))
    end

    def default_attributes
      { created_at: Time.current, updated_at: Time.current,
        uuid: SecureRandom.uuid }
    end

    def sample_latency
      (1..500).to_a.sample.seconds
    end

    def sample_queue(job)
      @sample_queues ||= {}
      @sample_queues[job] ||=
        %w(default mailers high_priority low_priority).sample
    end
  end
end
