class FedexTracker < ApplicationService
  attr_reader :tracking_number

  def initialize(tracking_number)
   @tracking_number = tracking_number
  end

  def call
    fedex_config = Rails.application.credentials.config[:fedex]
    fedex = Fedex::Shipment.new(
      :key => fedex_config[:key],
      :password => fedex_config[:password],
      :account_number => fedex_config[:account_number],
      :meter => fedex_config[:meter],
      :mode => 'test')
    results = fedex.track(:tracking_number => @tracking_number)
    tracking_info = results.first
    puts tracking_info
  end
end
  