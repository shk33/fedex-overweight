class HomeController < ApplicationController
  def index
    package_info_1 = {
      tracking_number: "149331877648230",
      carrier: "FEDEX",
      parcel: {
        length: 29.7,
        width: 5,
        height: 21,
        weight: 2.0,
        distance_unit: "CM",
        mass_unit: "KG"
      }
    }
    package_info_2 = {
      tracking_number: "449044304137821",
      carrier: "FEDEX",
      parcel: {
        length: 30,
        width: 25,
        height: 10,
        weight: 1,
        distance_unit: "CM",
        mass_unit: "KG"
      }
    }
    delivery_manager = DeliveryPackageManager.new [package_info_1, package_info_2]
    delivery_manager.generate_overweight_data
  end
end
