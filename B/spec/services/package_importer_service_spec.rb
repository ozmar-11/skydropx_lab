require 'rails_helper'

RSpec.describe PackageImporterService do
  describe '#log_packages_into_kafka' do
    let(:packages) do
      [
        {
          "tracking_number" => "449044304137821",
          "carrier" => "FEDEX"
        },
        {
            "tracking_number" => "920241085725456",
            "carrier" => "FEDEX"
        }
      ]
    end

    before do
      allow(PackageImporterService).to receive(:packages).and_return(packages)
    end

    it 'should use the correct service to log into kafka' do
      expect(FedExTrackerService).to receive(:log_into_kafka).exactly(packages.size).times

      PackageImporterService.log_packages_into_kafka
    end
  end
end
