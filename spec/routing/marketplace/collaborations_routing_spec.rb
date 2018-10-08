require "rails_helper"

RSpec.describe Marketplace::CollaborationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/marketplace/collaborations").to route_to("marketplace/collaborations#index")
    end

    it "routes to #show" do
      expect(:get => "/marketplace/collaborations/1").to route_to("marketplace/collaborations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/marketplace/collaborations").to route_to("marketplace/collaborations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marketplace/collaborations/1").to route_to("marketplace/collaborations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marketplace/collaborations/1").to route_to("marketplace/collaborations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marketplace/collaborations/1").to route_to("marketplace/collaborations#destroy", :id => "1")
    end
  end
end
