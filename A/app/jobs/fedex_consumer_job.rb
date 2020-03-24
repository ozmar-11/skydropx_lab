class FedexConsumerJob < ApplicationJob
  queue_as :consumer

  def perform(*args)
    return if already_running_or_queued?

    KafkaConsumerService.new(
      consumer_group: ENV.fetch('KAFKA_FEDEX_CONSUMER_GROUP'),
      topic: ENV.fetch('KAFKA_FEDEX_TOPIC')
    ).save_packages_status
  end

  def already_running_or_queued?
    running_jobs = []

    Sidekiq::Workers.new.each do |_process_id, _thread_id, work|
      running_jobs.push(work['payload']['wrapped'])
    end

    running_jobs.include?(self.class.to_s)
  end
end
