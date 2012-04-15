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
      
      def write_division(division_mapping)  
        iso_code = division_mapping[:full_code][0..1]
        country = Country.find_by_iso_code_two_letter(iso_code)
      
        division = Division.find_or_initialize_by_geonames_id(division_mapping[:geonames_id])
        created_or_updating = division.new_record? ? 'Creating' : 'Updating'
        division.country_id = country.id
        division.code = division_mapping[:full_code][3..-1]

        division.attributes = division_mapping.slice(:full_code,
                                                     :name,
                                                     :ascii_name,
                                                     :geonames_id)
        division.save!
        
        "#{created_or_updating} db record for #{division_mapping[:full_code]}"
      end

      
      def write_cities(country_code, city_mappings)    
        country = Country.find_by_iso_code_two_letter(country_code)
        
        unless country.nil?
          city_mappings.each do |city_mapping|
            city = City.find_or_initialize_by_geonames_id(city_mapping[:geonames_id])
            city.country_id = country.id
          
            city.attributes = city_mapping.slice(:name,
                                                 :ascii_name,
                                                 :alternate_name,
                                                 :latitude,
                                                 :longitude,
                                                 :country_iso_code_two_letters,
                                                 :population,
                                                 :geonames_timezone_id,
                                                 :geonames_id,
                                                 :admin_1_code,
                                                 :admin_2_code,
                                                 :admin_3_code,
                                                 :admin_4_code)

            division = Division.find_by_full_code(city.country_iso_code_two_letters+"."+city.admin_1_code )
            city.division_id = division.id unless division.blank?
          
            city.save!
          end
          
          "Processed #{country.name}(#{country_code}) with #{city_mappings.length} cities"
        end
      end

    end
  end
end
