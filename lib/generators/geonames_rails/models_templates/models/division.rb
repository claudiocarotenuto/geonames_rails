class Division < ActiveRecord::Base
  belongs_to :country
  has_many :cities
end