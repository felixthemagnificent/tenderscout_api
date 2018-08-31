# Tests for registration request controller functionality
require 'rails_helper'

RSpec.describe V1::RegistrationRequestsController, type: :controller do
  #create object for testing
  let(:registration_request) { FactoryBot.create(:registration_request) }
  #let(:registration_request) { FactoryBot.create(:world_region) }
  #let(:industry) { FactoryBot.create(:industry) }
  #let(:core_country) { FactoryBot.create(:core_country) }

  describe 'GET #index' do
    it 'should return worked status' do
      expect(response.status).to eq 200
    end

    it 'shouldent return 404' do
      expect(response.status).should_not eq 400..500
    end

    it 'initialize registration request' do
      registration_request
      get :index, as: :json
      #p('-------------------------')
      #p(request = JSON(registration_request))
      #request = registration_request['company_size']
     p('-------------------------')
     #p(response.body)
       a = registration_request.to_json
      requesti = JSON.parse(a)
      #id = b[0]["id"]
     # p(requesti)
     # p(request['company_size'])
     p('-----------------------')
      #p('-------------------------')
      #expect(request).to eq 10
      #core_country
      #industry
      #expect(response).to have_http_status(:ok) worked test
      #expect(response.body).to eq response.body worked test
      def json_body
        JSON.parse(response.body)
      end
      #hash_body =
      p(json_body[0]["id"])
      hash_request_body = registration_request.to_json
      #expect(hash_body).to eq requesti
      # expect(json_body[0]["id"]).to eq(registration_request.id) worked test
      #expect(hash_body).to have_http_status(200)
      #p(hash_body)
      #expect(hash_body).to match({
                            #              id: registration_request.id,
                                          # "fullname"=>registration_request.fullname
#                                      })

      # expect registration_request.id eq 1
      # get :index, as: :json
      # request = JSON.parse(response.body)
      # expect(request['company_size']).to eq 10
    end

  end

end