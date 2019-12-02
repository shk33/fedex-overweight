class HomeController < ApplicationController
  before_action :validate_report_params, only: [:generate_report]
  
  def index
  end

  def show_report
  end
  
  def generate_report
    begin
      labels_file = params[:labels].read
      labels_data = JSON.parse(labels_file)
      puts "Labels length #{labels_data.length}"
      delivery_manager = DeliveryPackageManager.new labels_data
      @data = delivery_manager.generate_overweight_data
      puts @data
      # @data = "Hola"
      # puts 'Hello before render'
      # render "generate_report"
    rescue
      flash[:error] = "An error ocurred. Probably the Fedex API is down. Tyr again later"
      redirect_to root_url
    end
  end

  private
  def validate_report_params
    unless params[:labels].present?
      flash[:error] = "The labels file was not submited"
      redirect_to root_url
    end
  end
end
