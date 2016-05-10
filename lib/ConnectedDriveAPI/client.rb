module ConnectedDriveAPI
  class Client
    include HTTParty
      
    base_uri "https://b2vapi.bmwgroup.com/webapi/v1"
    
    attr_reader :email, :refresh_token, :client_secret, :token
    
    def initialize( email, client_secret )
      @email = email
      @client_secret = client_secret
      self.class.headers "User-Agent"   => "MCVApp/1.5.2 (iPhone; iOS 9.1; Scale/2.00)"

    end
    
    def token=(token)
      @token = token
      self.class.headers "Authorization" => "Bearer #{token}"
    end
    
    def refresh_token=(token)
      @refresh_token = token      
    end
    
    def update_token()
      response = self.class.post(
        "https://b2vapi.bmwgroup.com/webapi/oauth/token",
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded",
          "Authorization" => "Basic #{@client_secret}"
        },
        body: {
          "grant_type" => "refresh_token",
          "refresh_token" => self.refresh_token
        }
      )
      
      self.refresh_token = response["refresh_token"]
      self.token = response["access_token"]
    end
    
    def login!(password)
      response = self.class.post(
        "https://b2vapi.bmwgroup.com/webapi/oauth/token",
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded",
          "Authorization" => "Basic #{@client_secret}"
        },
        body:{
          "grant_type" => "password",
          "scope" => "remote_services vehicle_data",
          "username" => email,
          "password" => password
        }
      )
      
      self.refresh_token = response["refresh_token"]
      self.token = response["access_token"]
    end
    
    def vehicles
      self.class.get("/user/vehicles")["vehicles"].map { |v| Vehicle.new( self.class, v["vin"], v ) }
    end
    
  end
end