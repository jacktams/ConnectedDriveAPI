module ConnectedDriveAPI
  class Vehicle
    attr_reader :api, :email, :vin, :vehicle, :capabilites

    
    def initialize(api, vin, vehicle)
      @api = api
      @vin = vin
      @vehicle = vehicle
    end
    
    def status()
      if ( !self.vehicle[VehicleDetails::STATS_AVAILABLE] == VehicleCapabilities::TRUE )
        raise "Status Service not supported by #{vin}"
      end
      
      api.get("/user/vehicles/#{vin}/status",
        body: {
          "deviceTime" => Time.new.strftime("%Y-%m-%dT%H:%M:%S")
        }
      )["vehicleStatus"]
    end
    
    def lastTrip()
      if ( !self.vehicle[VehicleDetails::STATS_AVAILABLE] == VehicleCapabilities::TRUE )
        raise "Status Service not supported by VIN: #{vin}"
      end
      
      api.get("/user/vehicles/#{vin}/statistics/lastTrip")["lastTrip"]
    end
    
    def allTrips()
      if ( !self.vehicle[VehicleDetails::STATS_AVAILABLE] == VehicleCapabilities::TRUE )
        raise "Status Service not supported by VIN: #{vin}"
      end
      
      api.get("/user/vehicles/#{vin}/statistics/allTrips")["allTrips"]      
    end
    
    def rangeMap()
      if ( self.vehicle[VehicleCapabilities::RANGE_MAP] == VehicleCapabilities::NOT_SUPPORTED )
        raise "Range Map not supported by VIN: #{vin}"
      end
      
      api.get("/user/vehicles/#{vin}/rangemap")["rangemap"]      
    end
    
    def destinations()
      if ( self.vehicle[VehicleCapabilities::LAST_DEST] == VehicleCapabilities::NOT_SUPPORTED )
        puts self.vehicle[VehicleCapabilities::LAST_DEST]
        raise "Destination Service not supported by VIN: #{vin}"
      end
      
      api.get("/user/vehicles/#{vin}/destinations")       
    end
    
    def chargingProfile()
      if ( self.vehicle[VehicleCapabilities::CHARGING_CONTROL] == VehicleCapabilities::NOT_SUPPORTED )
        raise "Charing Profile not supported by VIN: #{vin}"
      end
      
      api.get("/user/vehicles/#{vin}/chargingprofile")      
    end
    
    def sendPOI(poi)
      if ( self.vehicle[VehicleCapabilities::SEND_POI] == VehicleCapabilities::NOT_SUPPORTED )
        raise "Send POI Service not supported by VIN: #{vin}"
      end
      
      api.post("/user/vehicles/#{vin}/sendpoi",
      body: {
        "data" => "#{poi}"
      }
      )
    end
    
  end
end