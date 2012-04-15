Gem::Specification.new do |s|
  s.name = 'geonames_rails'
  s.version = '0.2.1'
  s.date = '2012-04-16'
  s.summary = "Geonames.org support for Rails applications"
  s.description = "Fetch data from geonames.org and make the required models"
  s.authors = ["Marius Andra", "Garrett Davis", "John Barton"]
  s.email = 'marius.andra@gmail.com'
  s.homepage = 'http://rubygems.org/gems/geonames-rails'

  s.files        = Dir["{lib}/**/*.rb", "{lib}/**/*.rake", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  s.add_runtime_dependency "rubyzip"
  s.add_development_dependency "rubyzip"

end
