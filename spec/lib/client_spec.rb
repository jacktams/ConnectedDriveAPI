require 'spec_helper'

RSpec.describe ConnectedDriveAPI::Client do
  subject(:connecteddrive_api) { ConnectedDriveAPI::Client.new( ENV["BMW_USER"], ENV["BMW_CLIENT_ID"] )}

  describe "#token=" do
    it "sets a Bearer token" do
      connecteddrive_api.token = Faker::Lorem.characters(32)
      expect(connecteddrive_api.class.headers).to include({"Authorization" => /Bearer [a-z0-9]{32}/})
    end
  end
  
  describe "#login!", vcr: { cassette_name: "client-login" } do
    it { is_expected.to be_a(ConnectedDriveAPI::Client) }
    
    it "logs into ConnectedDrive" do
      connecteddrive_api.login!(ENV["BMW_PASSWORD"])
      expect(a_request(:post, "https://#{URI.parse(connecteddrive_api.class.base_uri).host}/webapi/oauth/token")).to have_been_made.once
    end
    
    it "obtains a Bearer token" do
      connecteddrive_api.login!(ENV["BMW_PASSWORD"])
      expect(connecteddrive_api.token).to match(/[a-zA-Z0-9]{32}/)
    end
    
    it "objects a Refresh token" do
      connecteddrive_api.login!(ENV["BMW_PASSWORD"])
      expect(connecteddrive_api.refresh_token).to match(/[a-zA-Z0-9]{32}/)
    end
    
    it "sets a Bearer token header" do
      connecteddrive_api.login!(ENV["BMW_PASSWORD"])
      expect(connecteddrive_api.class.headers).to include ({ "Authorization" => /Bearer [a-zA-Z0-9]{32}/ })
    end
    
    describe "#vehicles", vcr: { cassette_name: "client-vehicles" } do
      it "lists all vehicles associated with ConnectedDrive user" do 
        expect(connecteddrive_api.vehicles).to include(ConnectedDriveAPI::Vehicle)
      end
    end
    
    describe "#update_token", vcr: { cassette_name: "client-token" } do
      it "updates the refresh_token and Bearer Token" do 
        connecteddrive_api.login!(ENV["BMW_PASSWORD"])
        old_token = connecteddrive_api.token
        old_refresh = connecteddrive_api.refresh_token
        
        connecteddrive_api.update_token()
        expect(connecteddrive_api.refresh_token).to match(/[a-zA-Z0-9]{32}/)
        expect(connecteddrive_api.token).to match(/[a-zA-Z0-9]{32}/)
        expect(connecteddrive_api.token).not_to match(old_token)
        expect(connecteddrive_api.refresh_token).not_to match(old_refresh)
      end
    end
    
  end
end
