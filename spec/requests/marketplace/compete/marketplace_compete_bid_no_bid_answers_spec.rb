require 'rails_helper'

RSpec.describe "Marketplace::Compete::BidNoBidAnswers", type: :request do
  describe "GET /marketplace_compete_bid_no_bid_answers" do
    it "works! (now write some real specs)" do
      get marketplace_compete_bid_no_bid_answers_path
      expect(response).to have_http_status(200)
    end
  end
end
