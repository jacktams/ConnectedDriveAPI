module ConnectedDriveAPI
  class ChargingPOI
    attr_reader: api
    
    def initialize( api )
      @api = api
    end
    
    def searchPOI(lat, long, radius=20)
      api.get("/chargingstations/searchstatic",
        body: {
          "lat" => lat,
          "long" => long,
          "radius" => radius
        }
      )
    end
    
    def getChargeStationInfo(ids)
      
    end
  end
end