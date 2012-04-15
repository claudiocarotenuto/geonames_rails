require 'geonames_rails/mappings/base'
require 'geonames_rails/mappings/city'
require 'geonames_rails/mappings/country'
require 'geonames_rails/mappings/division'
require 'zip/zipfilesystem'

module GeonamesRails
  
  class Loader
    
    def initialize(puller, writer, logger = nil)
      @logger = logger || STDOUT
      @puller = puller
      @writer = writer
    end
    
    def load_data
      @puller.pull if @puller # pull geonames files down
      
      load_countries
      load_cities
      load_divisions
      
      @puller.cleanup if @puller # cleanup the geonames files
    end
    
  protected
    def load_countries
      log_message "opening countries file"
      File.open(File.join(Rails.root, 'tmp', 'countryInfo.txt'), 'r') do |f|
        f.each_line do |line|
          # skip comments
          next if line.match(/^#/) || line.match(/^iso/i)
          
          country_mapping = Mappings::Country.new(line)
          result = @writer.write_country(country_mapping)
          
          log_message result
        end
      end
    end

    def load_divisions
      log_message "opening divisions file"
      File.open(File.join(Rails.root, 'tmp', 'admin1CodesASCII.txt'), 'r') do |f|
        f.each_line do |line|
          # skip comments
          next if line.match(/^#/) || line.match(/^iso/i)

          division_mapping = Mappings::Division.new(line)
          result = @writer.write_division(division_mapping)
          
          #log_message result
        end
      end

    end
    
    def load_cities
      city_file = "cities1000"

      log_message "Loading city file #{city_file}"
      cities = []

      Zip::ZipFile.open(File.join(Rails.root, 'tmp', "#{city_file}.zip"), 'r') do |zipfile|
        zipfile.each do |f|
          zipfile.read(f).split(/\n/).each { |line| cities << Mappings::City.new(line) }
        end
      end
      
      log_message "#{cities.length} cities to process"
      
      cities_by_country_code = cities.group_by { |city_mapping| city_mapping[:country_iso_code_two_letters] }
      
      cities_by_country_code.keys.each do |country_code|
        cities = cities_by_country_code[country_code]
        
        result = @writer.write_cities(country_code, cities)
        
        log_message result
      end
    end
    
    def log_message(message)
      @logger << message
      @logger << "\n"
    end
  end
end