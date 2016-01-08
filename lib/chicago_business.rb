require "chicago_business/version"
require "unirest"

module ChicagoBusiness
  class Business
    attr_reader :job_titles, :city, :name, :doing_business_as_name

    def initialize(input_options)
      @license_description = input_options["license_description"]
      @city = input_options["city"]
      @name = input_options["name"]
      @doing_business_as_name = input_options["doing_business_as_name"]
    end

    def self.all
      data_array = Unirest.get('https://data.cityofchicago.org/resource/uupf-x98q.json').body
      create_businesses(data_array)
    end

    def self.find(input_search_terms)
      data_array = Unirest.get("https://data.cityofchicago.org/resource/uupf-x98q.jsons?$q=#{input_search_terms}").body
      create_businesses(data_array)
    end

    private

    def self.create_businesses(input_data_array)
      businesses = []
      input_data_array.each do |business_data|
        businesses << Business.new(business_data)
      end
      businesses
    end
  end
end

