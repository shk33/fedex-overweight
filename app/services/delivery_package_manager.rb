class DeliveryPackageManager
  def initialize delivery_packages
    @delivery_packages = delivery_packages
  end
    
  def generate_overweight_data
    hydrated_packages = hydrate_real_parcel
    package_instances = []
    
    hydrated_packages.each do |delivery_package_data|
      instance = Domain::DeliveryPackage.new(
        delivery_package_data[:tracking_number],
        delivery_package_data[:carrier],
        delivery_package_data[:parcel],
        delivery_package_data[:real_parcel]
      )
      package_instances.push instance
    end

    package_instances.each do |package_instance|
      puts "Total Weight: #{package_instance.calculate_total_weight}"
      puts "Real Total Weight #{package_instance.calculate_real_total_weight}"
      puts "Over Weight "
      puts "#{package_instance.get_overweight_data}"
      puts ""
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