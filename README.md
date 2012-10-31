Geonames-Rails
===
Update 2
---
Converted the plugin into a gem

Copy this into your application's Rakefile:

```ruby
geonames_gem = RUBY_VERSION < "1.9.3" ? Gem.searcher.find("geonames_rails") : Gem::Specification.find_by_name('geonames_rails')
Dir["#{geonames_gem.full_gem_path}/lib/tasks/*.rake"].each { |ext| load ext }
```

To generate the migration and models, use

```ruby
  rails generate geonames_rails:migration
  rails generate geonames_rails:models
```

Migrate your database with

```ruby
rake db:migrate
```

And to do the magic, run

```ruby
  rake geonames_rails:pull  # to download the data
  rake geonames_rails:load  # to load it
  rake geonames_rails:run   # to do both at once (use for heroku)
```

Thanks to Garrett Davis for converting it into Rails 3 and John Barton for making the thing in the first place.


Update
---

Updated the plugin for Rails 3 (v3.0.7 clean install)

  * Recoded Generators
  * Moved tasks/geonames_rails.rake to lib/tasks/geonames_rails.rake
  * Added force_encoding to correct encoding errors in puller.rb

Thanks to John Barton (joho) for saving me some time, hopefully this fork does the same.


Getting Started
---

I need a decent plugin that can do the following things with [the geonames database](http://www.geonames.org/)

  * generate a standard db migration
  * pull down the required geonames files from the web
  * load those geonames files in the db (assuming a schema from the migration)
  * generate me my models for free (but leave them in models so i can hack them up later)

Install the plugin by doing the following in your rails app root dir

  script/plugin install git://github.com/joho/geonames-rails.git

You next step is to run the generators to give you the bare bones country/city models and the db migration

  script/generate geonames_migration
  script/generate geonames_models

Once you've run that migration and got your models set up how you like you're right to pull down the data straight from the geonames server and into your database. It's as easy as one little command

  rake geonames_rails:pull_and_load_data

Advanced Usage
---

OK, so you've had a bit of a play and decided one of a couple of things

  * the default fields i've chosen suck and you want more/less of them
  * you don't like the storage method i've chosen. maybe you want to use a document store - or something else

Well, you're covered. The method for writing out the country/city data is fully pluggable. All you need is a class that implements the following two methods

  class MyCustomGeonamesWriter
    def write_country(country_mapping)
    end

    def write_cities(country_code, city_mappings)
    end
  end

and then you can pass an instance of that class as the second argument to the geonames loader. See the rake task for an example.

---

Outstanding Tasks
---

TODO

  * add regions? (maybe, i'm not sure they're worth it)

DONE

  * rake task that will pull the latest geonames data into temp files
  * generators for the db migration and models
  * actually put something in the db migrations
  * allow you to declare which fields you're using from geonames
    - currently store the mappings between field names and column of data in classing in the Mappings module
    - pulled out the writing of the records into a class
    - changed the loader so you can plug in whatever writer you want
  * write the text to AR converter

---

Copyright John Barton 2009