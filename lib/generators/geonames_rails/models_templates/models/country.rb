class Country < ActiveRecord::Base
  has_many :cities
  #has_many :divisions
  attr_accessible :iso_code_two_letter, :iso_code_three_letter, :iso_number,
    :name, :capital, :population, :continent, :currency_name, :currency_code,
    :geonames_id
  end