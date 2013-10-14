class Country < ActiveRecord::Base
  has_many :cities
  has_many :divisions
  has_many :geonames_alternate_names, :as => :translatable, :class_name => 'AlternateName'
  
  attr_accessible :iso_code_two_letter, :iso_code_three_letter, :iso_number, :name, :capital, :continent, :geonames_id, :alternate_names
  
  def localized_name
    translations = geonames_alternate_names.in_language(I18n.locale)
    return name if translations.empty?
    translations.each do |t|
        return t.alternate_name if t.preferred_name?
    end
    translations.first.alternate_name
  end
  
end