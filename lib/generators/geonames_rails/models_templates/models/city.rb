class City < ActiveRecord::Base
  belongs_to :country
  #belongs_to :division
  attr_accessible :name, :ascii_name, :alternate_name, :latitude, :longitude,
    :country_iso_code_two_letters, :population, :geonames_timezone_id,
    :geonames_id, :admin_1_code, :admin_2_code, :admin_3_code, :admin_4_code
end