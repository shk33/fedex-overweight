module Helpers
  class UnitConverter
    def self.lb_to_kg pounds
      pounds * 0.454
    end
  
    def self.in_to_cm inches
      inches * 2.54
    end
  end
end