require 'fedex'

class FedExTrackerService
  ERROR_STATUS = 'EXCEPTION'
  ON_TRANSIT_STATUS = 'ON_TRANSIT'
  FEDEX_TO_B_STATUS_EQUIBALENCES = {
    'At Pickup' => 'CREATED',
    'Delivered' => 'DELIVERED'
  }

  class << self
    def shipment(tracking_number)
      fedex.track(tracking_number: tracking_number)
    end

    def shipment_status(tracking_number)
      begin
        FEDEX_TO_B_STATUS_EQUIBALENCES.fetch(shipment(tracking_number).first.status, ON_TRANSIT_STATUS)
      rescue Fedex::RateError
        ERROR_STATUS
      end
    end

    def log_into_kafka(tracking_number)
      key = "FEDEX<=>#{tracking_number}"
      message = shipment_status(tracking_number)

      KafkaService.queue_message(
        key: key,
        message: message,
        topic: ENV.fetch('KAFKA_FEDEX_TOPIC')
      )
    end

    private

    def fedex
      @@fedex ||= Fedex::Shipment.new(fedex_credentials)
    end

    def fedex_credentials
      {
        key: ENV.fetch('FEDEX_KEY'),
        password: ENV.fetch('FEDEX_PASSWORD'),
        account_number: ENV.fetch('FEDEX_ACCOUNT_NUMBER'),
        meter: ENV.fetch('FEDEX_METER'),
        mode: ENV.fetch('FEDEX_MODE')
      }
    end
  end
end
