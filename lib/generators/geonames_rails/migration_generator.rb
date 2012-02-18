require 'rails/generators'
require 'rails/generators/base'

module GeonamesRails
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'migration_templates'))
 
      def manifest
        record do |m|
          m.migration_template 'geonames_tables.rb',"db/migrate", :migration_file_name => "create_geonames_tables"
        end
      end
    end
    
  end
end
