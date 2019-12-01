class DeliveryPackageManager
  def initialize delivery_packages
    @delivery_packages = delivery_packages
  end
    
  def generate_overweight_data
    hydrated_packages = hydrate_real_parcel
    hydrated_packages.each do |delivery_package|
      puts delivery_package
    end
  end

  private
  def  hydrate_real_parcel
    @delivery_packages.each do |delivery_package|
      tracking_info = FedexManager::FedexTracker.call delivery_package[:tracking_number]
      package_weight = tracking_info.details[:package_weight]
      package_dimensions = tracking_info.details[:package_dimensions]

      real_parcel = {
        length: package_dimensions[:length].to_f,
        width: package_dimensions[:width].to_f,
        height: package_dimensions[:height].to_f,
        weight: package_weight[:value].to_f,
        distance_unit: package_dimensions[:units],
        mass_unit: package_weight[:units]
      }

      delivery_package[:real_parcel] = real_parcel
    end
  end
end