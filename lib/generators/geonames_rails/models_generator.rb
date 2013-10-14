require 'rails/generators'
 
module GeonamesRails
  module Generators
    class ModelsGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'models_templates'))
      include Rails::Generators::Migration
      desc "add the geonames models (city, division, country and alternate_name)"
 
      def generate_models
        %w(country city division alternate_name).each do |model_name|
          copy_file "models/#{model_name}.rb", "app/models/#{model_name}.rb"
        end
      end
    end
    
  end
end