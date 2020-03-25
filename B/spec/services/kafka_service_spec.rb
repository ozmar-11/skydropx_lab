require 'rails_helper'

RSpec.describe KafkaService do
  describe '#queue_message' do
    before do
      allow_any_instance_of(Kafka::Producer).to receive(:produce).and_return(true)
    end

    it 'should call the produce method from kafka gem' do
      expect_any_instance_of(Kafka::AsyncProducer).to receive(:produce).once

      KafkaService.queue_message(message: 'message', key: 'key', topic: 'fedex_packages')
    end
  end
end
