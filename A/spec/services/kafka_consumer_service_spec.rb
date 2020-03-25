require 'rails_helper'

RSpec.describe KafkaConsumerService do
  let(:topic) { 'fedex_package' }
  let(:consumer_group) { 'fedex_package_consumer' }

  before do
    # mocked the kafka methods to avoid external calls on test environments
    consumer_double = double('Kafka::Consumer', stop: 'stoped', each_message: '', subscribe: 'subscribed')
    kafka_double = double(:Kafka, consumer: consumer_double)
    mocked_kafka_package = double('Package', key: 'FEDEX<=>PackageID', value: 'DELIVERED')

    allow(Kafka).to receive(:new).and_return(kafka_double)
    allow(consumer_double).to receive(:each_message) { |&block| block.call(mocked_kafka_package) }
  end

  describe '#save_packages_status' do
    it 'Should saved the received packages' do
      kafka_consumer = KafkaConsumerService.new(consumer_group: consumer_group, topic: topic)

      kafka_consumer.save_packages_status

      expect(Package.count).to eq(1)
    end
  end
end
