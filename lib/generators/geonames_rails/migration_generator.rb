require 'rails/generators'
require 'rails/generators/base'

module GeonamesRails
  module Generators
    class MigrationGenerator < Rails::Generator::Base
      #argument :actions, :type => :array, :default => [], :banner => "action action"
      check_class_collision :suffix => "GeonamesRails"
 
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'migration_templates'))
 
      #class_option :view_engine, :type => :string, :aliases => "-t", :desc => "Template engine for the views. Available options are 'erb' and 'haml'.", :default => "erb"
      #class_option :haml, :type => :boolean, :default => false

      def manifest
        record do |m|
          m.migration_template 'geonames_tables.rb',"db/migrate", :migration_file_name => "create_geonames_tables"
        end
      end
    end
    
  end
end