module GeonamesRails
  module Mappings
    class Division < Base
    protected
      def mappings
        {
          :full_code => 0,
          :name => 1,
          :ascii_name => 2,
          :geonames_id => 3
        }
      end
    end
  end
end