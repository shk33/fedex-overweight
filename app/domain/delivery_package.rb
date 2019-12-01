module Domain
  class DeliveryPackage
    attr_reader :tracking_number
    attr_reader :carrier
    attr_reader :parcel
    attr_reader :real_parcel

    def initialize(tracking_number, carrier, parcel, real_parcel)
      @tracking_number = tracking_number
      @carrier = carrier
      @parcel = parcel
      @real_parcel = real_parcel
    end

    def calculate_label_total_weight
      calculate_total_weight @parcel
    end

    def calculate_real_total_weight
      calculate_total_weight @real_parcel
    end
    
    def calculate_total_weight parcel
      volumetric_weight = calculate_volumetric_weight
      parcel[:weight] > volumetric_weight ? parcel[:weight] : volumetric_weight
    end
    
    def calculate_volumetric_weight parcel
      (parcel[:length] * parcel[:width] * parcel[:weight])/5000
    end
  end
end