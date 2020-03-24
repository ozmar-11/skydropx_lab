class FedexProducerJob < ApplicationJob
  queue_as :producer

  def perform(*args)
    return if already_running_or_queued?

    PackageImporterService.log_packages_into_kafka
  end

  def already_running_or_queued?
    running_jobs = []

    Sidekiq::Workers.new.each do |_process_id, _thread_id, work|
      running_jobs.push(work['payload']['wrapped'])
    end

    running_jobs.include?(self.class.to_s)
  end
end
