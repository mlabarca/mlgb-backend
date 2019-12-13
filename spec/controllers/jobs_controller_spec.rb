require 'rails_helper'

RSpec.describe JobsController, type: :controller do

  describe 'GET #search' do
    let(:gb_json){
      File.read(Rails.root.join('spec', 'fixtures', 'jobs_response.json'))
    }

    let(:parsed_gb_json) { JSON.parse(gb_json) }

    before :each do
      response = Typhoeus::Response.new(code: 200, body: gb_json)
      Typhoeus.stub(/#{Rails.configuration.services[:gb_endpoint]}/).and_return(response)
    end

    it 'returns http success' do
      get :search
      expect(response).to have_http_status(:success)
    end

    it 'returns a filtered json array' do
      get :search
      response_json = JSON.parse(response.body)
      expect(response_json['jobs']).to eq parsed_gb_json['jobs']
    end
  end

end
