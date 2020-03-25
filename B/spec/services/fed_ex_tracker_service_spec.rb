require 'rails_helper'

RSpec.describe FedExTrackerService do
  describe '#shipment_status' do
    before do
      mocked_fedex_package = double('Fedex::Package', status: 'Delivered')
      allow_any_instance_of(Fedex::Shipment).to receive(:track).and_return([mocked_fedex_package])
    end

    it 'should return the status of the package' do
      package_status = FedExTrackerService.shipment_status('packageID')

      expect(package_status).to eq(FedExTrackerService::FEDEX_TO_B_STATUS_EQUIBALENCES['Delivered'])
    end
  end

  describe '#log_into_kafka' do
    before do
      allow(KafkaService).to receive(:queue_message).and_return(true)
    end

    it 'Should call the queue message from kafka service' do
      expect(FedExTrackerService).to receive(:log_into_kafka).once

      FedExTrackerService.log_into_kafka('packageID')
    end
  end
end
