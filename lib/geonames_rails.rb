Dir["tasks/**/*.rake"].each { |ext| load ext } if defined?(Rake)

require 'open-uri'
require 'fileutils'

require 'geonames_rails/loader'
require 'geonames_rails/puller'
require 'geonames_rails/writers/dry_run'
require 'geonames_rails/writers/active_record'

require 'generators/geonames_rails/migration_generator'
require 'generators/geonames_rails/models_generator'
puts 'this code runs'
