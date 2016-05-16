module ConnectedDriveAPI
  class Client
    include HTTParty
      
    HUB_ECE    = "https://b2vapi.bmwgroup.com"
    HUB_US     = "https://b2vapi.bmwgroup.us"
    HUB_CN     = "https://b2vapi.bmwgroup.cn:8592"
    
    attr_reader :email, :refresh_token, :client_secret, :token, :hub
    
    # Initialises client, hub defaults to HUB_ECE, but can be HUB_US or HUB_CN
    # it is assumed that the HUB is constant for the lifetime of the object.
    def initialize( email, client_secret, hub=Client::HUB_ECE )
      @email = email
      @client_secret = client_secret
        
      self.class.headers "User-Agent"   => "MCVApp/1.5.2 (iPhone; iOS 9.1; Scale/2.00)"
      self.update_hub( hub )
    end
    
    def update_hub( hub )
      @hub = hub
      self.class.base_uri "#{@hub}/webapi/v1"
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
        "#{@hub}/webapi/oauth/token",
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
        "#{@hub}/webapi/oauth/token",
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
