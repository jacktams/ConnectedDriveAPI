module ConnectedDriveAPI
  class Vehicle
    attr_reader :api, :email, :vin, :vehicle
    
    def initialize(api, vin, vehicle)
      @api = api
      @vin = vin
      @vehicle = vehicle
    end
    
    def status()
      api.get("/user/vehicles/#{vin}/status",
        body: {
          "deviceTime" => Time.new.strftime("%Y-%m-%dT%H:%M:%S")
        }
      )["vehicleStatus"]
    end
    
    def lastTrip()
      api.get("/user/vehicles/#{vin}/statistics/lastTrip")["lastTrip"]
    end
    
    def allTrips()
      api.get("/user/vehicles/#{vin}/statistics/allTrips")["allTrips"]      
    end
    
    def rangeMap()
      api.get("/user/vehicles/#{vin}/rangemap")["rangemap"]      
    end
    
    def destinations()
      api.get("/user/vehicles/#{vin}/destinations")       
    end
    
    def chargingProfile()
      api.get("/user/vehicles/#{vin}/chargingprofile")      
    end
    
    def sendPOI(poi)
      api.post("/user/vehicles/#{vin}/sendpoi",
      body: {
        "data" => "#{poi}"
      }
      )
    end
    
  end
end