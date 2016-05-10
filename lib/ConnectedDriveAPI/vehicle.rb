module ConnectedDriveAPI
  class Vehicle
    attr_reader :api, :email, :id, :vehicle
    
    def initialize(api, vin, vehicle)
      @api = api
      @vin = vin
      @vehicle = vehicle
    end
    
    def status()
      api.get("/vehicles/#{vin}/status",
        body: {
          "deviceTime" => Time.new.strftime("%Y-%m-%dT%H:%M:%S")
        }
      )
    end
    
    def lastTrip()
      api.get("/user/vehicles/#{vin}/statistics/lastTrip")
    end
    
    def allTrips()
      api.get("/user/vehicles/#{vin}/statistics/allTrips")      
    end
    
    def rangeMap()
      api.get("/user/vehicles/#{vin}/rangemap")      
    end
    
    def destinations()
      api.get("/user/vehicles/#{vin}/destinations")       
    end
    
    def chargingProfile()
      api.get("/user/vehicles/#{vin}/chargingprofile")      
    end
    
  end
end