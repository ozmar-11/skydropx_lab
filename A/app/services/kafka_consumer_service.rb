require 'kafka'

class KafkaConsumerService
  attr_reader :kafka, :consumer, :topic

  def initialize(consumer_group:, topic:)
    @topic = topic
    @kafka = Kafka.new([ENV.fetch('KAFKA_SERVER')])
    @consumer = kafka.consumer(group_id: consumer_group)

    subscribe_consumer
  end

  def save_packages_status
    trap("TERM") { consumer.stop }

    consumer.each_message do |package|
      saved_package = Package.find_or_create_by(carrier_id: carrier_id(package.key), carrier: carrier_name(package.key))

      saved_package.update(status: package.value)
    end
  end

  private

  def carrier_id(message_key)
    message_key_items(message_key).second
  end

  def carrier_name(message_key)
    message_key_items(message_key).first
  end

  def message_key_items(message_key)
    message_key.split('<=>')
  end

  def subscribe_consumer
    consumer.subscribe(topic)
  end
end
