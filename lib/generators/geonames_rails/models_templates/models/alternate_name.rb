class AlternateName < ActiveRecord::Base
  belongs_to :translatable, :polymorphic => true
  attr_accessible :alternate_name_id, :geonames_id, :iso_language, :alternate_name, :preferred_name, :short_name
  #scope :in_language, lambda { |lang| { :conditions => ["iso_language = ?", "it"] } }
end