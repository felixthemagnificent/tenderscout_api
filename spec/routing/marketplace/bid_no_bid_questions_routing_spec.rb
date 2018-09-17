require "rails_helper"

RSpec.describe Marketplace::BidNoBidQuestionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/marketplace/bid_no_bid_questions").to route_to("marketplace/bid_no_bid_questions#index")
    end

    it "routes to #show" do
      expect(:get => "/marketplace/bid_no_bid_questions/1").to route_to("marketplace/bid_no_bid_questions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/marketplace/bid_no_bid_questions").to route_to("marketplace/bid_no_bid_questions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marketplace/bid_no_bid_questions/1").to route_to("marketplace/bid_no_bid_questions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marketplace/bid_no_bid_questions/1").to route_to("marketplace/bid_no_bid_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marketplace/bid_no_bid_questions/1").to route_to("marketplace/bid_no_bid_questions#destroy", :id => "1")
    end
  end
end
