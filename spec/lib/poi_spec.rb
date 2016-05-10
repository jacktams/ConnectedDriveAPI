require 'spec_helper'

RSpec.describe ConnectedDriveAPI::POI do 
  subject(:poi) { ConnectedDriveAPI::POI.new( "street", "city", "country", "postalCode", "subject", "53.69822", "-1.266915", "info", "name")}
  
  describe "POI" do
    it "sets a valid address" do
      expect(poi.street).to eq("street")
      expect(poi.city).to eq("city")
      expect(poi.country).to eq("country")
      expect(poi.postalCode).to eq("postalCode")
      expect(poi.subject).to eq("subject")
      expect(poi.lat).to eq("53.69822")
      expect(poi.lon).to eq("-1.266915")
      expect(poi.info).to eq("info")
      expect(poi.name).to eq("name")  
    end
    
    it "returns valid JSON" do
      expect(poi.to_s()).not_to be_empty
    end
    
  end

end
