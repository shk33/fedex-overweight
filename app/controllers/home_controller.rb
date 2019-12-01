class HomeController < ApplicationController
  def index
    tracking_number = "149331877648230"
    FedexTracker.call(tracking_number)
  end
end
