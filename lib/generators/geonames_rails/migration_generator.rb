require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/migration'

module GeonamesRails
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'migration_templates'))
      include Rails::Generators::Migration
      desc "add the geonames migrations"

      def generate_migration
        migration_template 'geonames_tables.rb',"db/migrate/create_geonames_tables.rb"
      end

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

    end
    
  end
end
