require "rails_helper"

RSpec.describe V1::Marketplace::TenderAwardCriteriaSectionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/marketplace/tender_award_criteria_sections").to route_to("v1/marketplace/tender_award_criteria_sections#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/marketplace/tender_award_criteria_sections/1").to route_to("v1/marketplace/tender_award_criteria_sections#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/marketplace/tender_award_criteria_sections").to route_to("v1/marketplace/tender_award_criteria_sections#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/marketplace/tender_award_criteria_sections/1").to route_to("v1/marketplace/tender_award_criteria_sections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/marketplace/tender_award_criteria_sections/1").to route_to("v1/marketplace/tender_award_criteria_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/marketplace/tender_award_criteria_sections/1").to route_to("v1/marketplace/tender_award_criteria_sections#destroy", :id => "1")
    end
  end
end
