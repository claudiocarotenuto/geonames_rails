class City < ActiveRecord::Base
  belongs_to :country
  belongs_to :division
  attr_accessible :name, :ascii_name, :alternate_name, :latitude, :longitude,
    :feature_class, :feature_code,
    :country_iso_code_two_letters, :population, :geonames_timezone_id,
    :geonames_id, :admin_1_code, :admin_2_code, :admin_3_code, :admin_4_code, :alternate_names
  
  has_many :geonames_alternate_names, :as => :translatable, :class_name => 'AlternateName'

  delegate :localized_name, :to => :division, :allow_nil => true, :prefix => true
  delegate :localized_name, :to => :country, :allow_nil => true, :prefix => true
  
  scope :with_country_and_division, { :include => [:division, :country] }
  
  # Returns an array with all the parents of this city
  #
  # The first position in the array is the +country+ and up to 4 more positions
  # can contain the ADM1, ADM2, ADM3 and ADM4 divisions containing the city
  def containers
    return @containers unless @containers.nil?
    container_codes = []
    codes = code.split('|')
    container_codes << (codes = codes[0..-2]).join('|') while codes.size > 1
    # first is country code
    @containers = [country]
    # second, third can be parent administrative division if not nil
    # NOTE container codes is like: ["ES|58|PO", "ES|58", "ES"] (country is last)
    @containers += Division.find_all_by_code container_codes[0..-2], :order => :level if container_codes.size > 1
    return @containers
  end
  
  def localized_name
    translations = geonames_alternate_names.in_language(I18n.locale)
    return name if translations.empty?
    translations.each do |t|
        return t.alternate_name if t.preferred_name?
    end
    translations.first.alternate_name
  end
  
  def label_long
    [localized_name, division_localized_name, country_localized_name].join(", ")
  end
end