UnitConverterHelper = Helpers::UnitConverter

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

    def get_overweight_data
      label_weight = calculate_total_weight().ceil
      real_total_weight = calculate_real_total_weight()

      if(real_total_weight > label_weight)
        overweight_data = {
          has_overweight: true,
          label_weight:  label_weight, 
          real_weight:   real_total_weight,
          exceeding_weight: (real_total_weight - label_weight).ceil
        }
      else
        overweight_data = {
          has_overweight: false,
          label_weight:  label_weight,
          real_weight:   real_total_weight,
          exceeding_weight: 0
        }
      end

      overweight_data
    end
    
    def calculate_total_weight
      calculate_parcel_total_weight @parcel
    end

    def calculate_real_total_weight
      calculation_data = @real_parcel.dup
      if calculation_data['distance_unit'] == 'IN'
        calculation_data["length"] = UnitConverterHelper.in_to_cm calculation_data["length"]
        calculation_data["width"]  = UnitConverterHelper.in_to_cm calculation_data["width"]
        calculation_data["height"] = UnitConverterHelper.in_to_cm calculation_data["height"]
      end

      if calculation_data["mass_unit"] == 'LB'
        calculation_data["weight"] = UnitConverterHelper.lb_to_kg calculation_data["weight"]
      end
        
      calculate_parcel_total_weight calculation_data
    end

    private

    def calculate_parcel_total_weight parcel
      volumetric_weight = calculate_volumetric_weight parcel
      parcel["weight"] > volumetric_weight ? parcel["weight"] : volumetric_weight
    end
    
    def calculate_volumetric_weight parcel
      (parcel["length"] * parcel["width"] * parcel["height"])/5000.to_f
    end
  end
end