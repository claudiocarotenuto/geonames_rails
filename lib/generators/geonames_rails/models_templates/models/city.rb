class City < ActiveRecord::Base
  belongs_to :country
  #belongs_to :division
end