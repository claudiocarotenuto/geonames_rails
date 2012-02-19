module GeonamesRails
  module Writers
    class ActiveRecord
      
      def write_country(country_mapping)  
        iso_code = country_mapping[:iso_code_two_letter]
        c = Country.find_or_initialize_by_iso_code_two_letter(iso_code)
      
        created_or_updating = c.new_record? ? 'Creating' : 'Updating'
        
        c.attributes = country_mapping.slice(:iso_code_two_letter,
                                             :iso_code_three_letter,
                                             :iso_number,
                                             :name,
                                             :capital,
                                             :population,
                                             :continent,
                                             :currency_name,
                                             :currency_code,
                                             :geonames_id,
                                             :population)
        c.save!
        
        "#{created_or_updating} db record for #{iso_code}"
      end
      

      
      def write_cities(country_code, city_mappings)    
        country = Country.find_by_iso_code_two_letter(country_code)
        
        unless country.nil?
          city_mappings.each do |city_mapping|
            city = City.find_or_initialize_by_geonames_id(city_mapping[:geonames_id])
            city.country_id = country.id
          
            city.attributes = city_mapping.slice(:name,
                                                 :asciiname,
                                                 :alternatenames,
                                                 :latitude,
                                                 :longitude,
                                                 :country_iso_code_two_letters,
                                                 :population,
                                                 :geonames_timezone_id,
                                                 :geonames_id)
          
            city.save!
          end
          
          "Processed #{country.name}(#{country_code}) with #{city_mappings.length} cities"
        end
      end

    end
  end
end
