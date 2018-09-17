require "rails_helper"

RSpec.describe Marketplace::BidNoBidAnswersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/marketplace/bid_no_bid_answers").to route_to("marketplace/bid_no_bid_answers#index")
    end

    it "routes to #show" do
      expect(:get => "/marketplace/bid_no_bid_answers/1").to route_to("marketplace/bid_no_bid_answers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/marketplace/bid_no_bid_answers").to route_to("marketplace/bid_no_bid_answers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marketplace/bid_no_bid_answers/1").to route_to("marketplace/bid_no_bid_answers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marketplace/bid_no_bid_answers/1").to route_to("marketplace/bid_no_bid_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marketplace/bid_no_bid_answers/1").to route_to("marketplace/bid_no_bid_answers#destroy", :id => "1")
    end
  end
end
