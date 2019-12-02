require 'test_helper'

class DeliveryPackageTest < ActiveSupport::TestCase
  test "should select weight as total weight when volumetric weight is lower" do
    tracking_number = "149331877648230"
    carrier = "Fedex"
    parcel = Hash[
      "length", 29.7,
      "width", 5,
      "height", 21,
      "weight", 2.0,
      "distance_unit", "CM",
      "mass_unit", "KG"
    ]
    real_parcel = Hash[
      "length", 30,
      "width", 8,
      "height", 22,
      "weight", 3,
      "distance_unit", "CM",
      "mass_unit", "KG"
    ]

    delivery = Domain::DeliveryPackage.new(
      tracking_number,
      carrier,
      parcel,
      real_parcel,
    )
    
    assert_equal 2, delivery.calculate_total_weight
  end

  test "should select volumetric weight as total weight when volumetic weight is bigger" do
    tracking_number = "149331877648230"
    carrier = "Fedex"
    parcel = Hash[
      "length", 30,
      "width", 25,
      "height", 10,
      "weight", 1,
      "distance_unit", "CM",
      "mass_unit", "KG"
    ]
    real_parcel = Hash[
      "length", 30,
      "width", 8,
      "height", 22,
      "weight", 3,
      "distance_unit", "CM",
      "mass_unit", "KG"
    ]

    delivery = Domain::DeliveryPackage.new(
      tracking_number,
      carrier,
      parcel,
      real_parcel,
    )
    
    assert_equal 1.5, delivery.calculate_total_weight
  end

  test "should calculate real total weight converting mass from LB to KG" do
    tracking_number = "149331877648230"
    carrier = "Fedex"
    parcel = Hash[
      "length", 30,
      "width", 25,
      "height", 10,
      "weight", 1,
      "distance_unit", "CM",
      "mass_unit", "KG"
    ]
    real_parcel = Hash[
      "length", 30,
      "width", 8,
      "height", 22,
      "weight", 10,
      "distance_unit", "CM",
      "mass_unit", "LB"
    ]

    delivery = Domain::DeliveryPackage.new(
      tracking_number,
      carrier,
      parcel,
      real_parcel,
    )
    
    assert_equal 4.54, delivery.calculate_real_total_weight
  end

  test "should calculate real total weight converting dimensions from IN to CM" do
    tracking_number = "149331877648230"
    carrier = "Fedex"
    parcel = Hash[
      "length", 30,
      "width", 25,
      "height", 10,
      "weight", 1,
      "distance_unit", "CM",
      "mass_unit", "KG"
    ]
    real_parcel = Hash[
      "length", 15,
      "width", 7,
      "height", 11,
      "weight", 1,
      "distance_unit", "IN",
      "mass_unit", "KG"
    ]

    delivery = Domain::DeliveryPackage.new(
      tracking_number,
      carrier,
      parcel,
      real_parcel,
    )
    
    assert_equal 3.79, delivery.calculate_real_total_weight.round(2)
  end
end
