require 'json'

class PackageImporterService
  # Use this hash to process packages from different carriers
  CARRIER_SERVICES = {
    'FEDEX' => FedExTrackerService
  }

  class << self
    def log_packages_into_kafka
      packages.each do |package|
        CARRIER_SERVICES.fetch(package['carrier']).log_into_kafka(package['tracking_number'])
      end
    end

    private
    # This method can be easily changed for a call to the correct provider API
    # or use a background job to get the packages info
    def packages
      file = File.open(Rails.root.join('shipments_data.json'))
      packages = JSON.load(file)

      file.close
      packages
    end
  end
end
