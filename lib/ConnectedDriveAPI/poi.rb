module ConnectedDriveAPI
  class POI
    
    attr_reader :street, :city, :country, :postalCode, :subject, :lat, :lon, :info, :name
    
    def initialize(street, city, country, postalCode, subject, lat, lon, info, name)
      @street = street
      @city = city
      @country = country
      @postalCode = postalCode
      @subject = subject
      @lat = lat
      @lon = lon
      @info = info
      @name = name
    end
    
    def to_s()
      {"poi" => 
        {
          "street" => street,
          "city" => city,
          "country" => country,
          "postalCode" => postalCode,
          "subject" => subject,
          "lat" => lat,
          "lon" => lon, 
          "additionalInfo" => info, 
          "name" => name,
          "useAsDestination" => "true"
        }
      }.to_json
    end
    
  end
end
