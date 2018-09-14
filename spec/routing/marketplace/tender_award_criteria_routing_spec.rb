require "rails_helper"

RSpec.describe Marketplace::TenderAwardCriteriaController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/marketplace/tender_award_criteria").to route_to("marketplace/tender_award_criteria#index")
    end

    it "routes to #show" do
      expect(:get => "/marketplace/tender_award_criteria/1").to route_to("marketplace/tender_award_criteria#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/marketplace/tender_award_criteria").to route_to("marketplace/tender_award_criteria#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marketplace/tender_award_criteria/1").to route_to("marketplace/tender_award_criteria#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marketplace/tender_award_criteria/1").to route_to("marketplace/tender_award_criteria#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marketplace/tender_award_criteria/1").to route_to("marketplace/tender_award_criteria#destroy", :id => "1")
    end
  end
end
