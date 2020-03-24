require 'kafka'

class KafkaService
  class << self
    def queue_message(key:, message:, topic:)
      kafka_producer.produce(message, key: key, topic: topic)
    end

    private

    def kafka_producer
      @@kafka_producer ||= kafka.async_producer(
        delivery_interval: ENV.fetch('KAFKA_DELIVERY_INTERVAL').to_i,
        delivery_threshold: ENV.fetch('KAFKA_DELIVERY_THRESHOLD').to_i
      )
    end

    def kafka
      @@kafka ||= Kafka.new(
        [ENV.fetch('KAFKA_SERVER')],
        client_id: 'B-application',
        logger: Rails.logger
      )
    end

    at_exit { kafka.shutdown }
  end
end
