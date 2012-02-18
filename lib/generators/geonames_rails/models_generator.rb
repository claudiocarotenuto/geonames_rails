require 'rails/generators'
 
module GeonamesRails
  module Generators
    class ModelsGenerator < Rails::Generator::Base
      #argument :actions, :type => :array, :default => [], :banner => "action action"
      check_class_collision :suffix => "GeonamesRails"
 
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'models_templates'))
 
      def manifest
        record do |m|
          %w(country city).each do |model_name|
            m.file "models/#{model_name}.rb", "app/models/#{model_name}.rb"
          end
        end
      end
    end
    
  end
end