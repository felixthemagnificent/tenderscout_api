require "rails_helper"

RSpec.describe V1::Marketplace::BidNoBidQuestionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/marketplace/bid_no_bid_questions").to route_to("v1/marketplace/bid_no_bid_questions#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/marketplace/bid_no_bid_questions/1").to route_to("v1/marketplace/bid_no_bid_questions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/v1/marketplace/bid_no_bid_questions").to route_to("v1/marketplace/bid_no_bid_questions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/marketplace/bid_no_bid_questions/1").to route_to("v1/marketplace/bid_no_bid_questions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/marketplace/bid_no_bid_questions/1").to route_to("v1/marketplace/bid_no_bid_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/marketplace/bid_no_bid_questions/1").to route_to("v1/marketplace/bid_no_bid_questions#destroy", :id => "1")
    end
  end
end
