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
    
    def lastTrip(){
      api.get("/user/vehicles/#{vin}/statistics/lastTrip")
    }
    
    def allTrips(){
      api.get("/user/vehicles/#{vin}/statistics/allTrips")      
    }
    
    def rangeMap(){
      api.get("/user/vehicles/#{vin}/rangemap")      
    }
    
    def destinations(){
      api.get("/user/vehicles/#{vin}/destinations")       
    }
    
    def chargingProfile(){
      api.get("/user/vehicles/#{vin}/chargingprofile")      
    }  
    
  end
end