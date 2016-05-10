require 'spec_helper'

RSpec.describe ConnectedDriveAPI::Vehicle do 
  subject(:api) { ConnectedDriveAPI::Client.new( ENV["BMW_USER"], ENV["BMW_CLIENT_ID"] )}
  
  before do 
    api.login!(ENV["BMW_PASSWORD"])
  end
  
  subject(:vehicle) { api.vehicles.first }
    
  
  describe "#rangeMap", vcr: { cassette_name: "vehicle" } do
    context "Range Map Polylines" do
      subject { vehicle.rangeMap() }
      
      it { should include("center") }
      it { should include("quality") }
      it { should include("rangemaps") }
    end
  end
  
  describe "#chargeProfile", vcr: { cassette_name: "vehicle" } do
    context "weeklyPlanner" do
      subject { vehicle.chargingProfile() }
      it { should include("weeklyPlanner") }
    end
  end
  
  describe "#destinations", vcr: { cassette_name: "vehicle" } do
    context "destinations" do
      subject { vehicle.destinations() }
      it { should include("destinations") }
    end
  end
  
  describe "vehicle trips", vcr: { cassette_name: "vehicle" } do
    context "#lastTrip" do
      subject { vehicle.lastTrip() }
      
      it { should include("efficiencyValue") }
      it { should include("totalDistance") }
      it { should include("electricDistance") }      
      it { should include("avgElectricConsumption") }      
      it { should include("accelerationValue") }      
      it { should include("totalConsumptionValue") }            
      it { should include("auxiliaryConsumptionValue") }  
      it { should include("avgCombinedConsumption") }      
      it { should include("electricDistanceRatio") }      
      it { should include("savedFuel") }      
      it { should include("date") }      
      it { should include("duration") }      
      
    end
    
    context "#allTrips" do
      subject { vehicle.allTrips() }
      
      it { should include("avgElectricConsumption") }
      it { should include("avgRecuperation") }
      it { should include("chargecycleRange") }      
      it { should include("totalElectricDistance") }      
      it { should include("avgCombinedConsumption") }      
      it { should include("savedCO2") }            
      it { should include("savedCO2greenEnergy") }  
      it { should include("totalSavedFuel") }      
      it { should include("resetDate") }      
      
    end
  end
  
  describe "#status", vcr: { cassette_name: "vehicle" } do
    context "vehicle status info" do
      subject { vehicle.status() }
      
      it { should include("updateReason") }
      it { should include("connectionStatus") }
      it { should include("updateTime") }      
    end
  end
  
 describe "#sendPOI", vcr: { cassette_name: "vehicle" } do
   it "should send POI" do
     response = vehicle.sendPOI(ConnectedDriveAPI::POI.new( "street", "city", "country", "postalCode", "subject", "53.69822", "-1.266915", "info", "name"))
     expect(response.success?)
   end
  end
  
end
  