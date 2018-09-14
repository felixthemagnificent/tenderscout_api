require 'rails_helper'

RSpec.describe "Marketplace::TenderAwardCriteria", type: :request do
  describe "GET /marketplace_tender_award_criteria" do
    it "works! (now write some real specs)" do
      get marketplace_tender_award_criteria_path
      expect(response).to have_http_status(200)
    end
  end
end
