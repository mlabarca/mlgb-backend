require 'rails_helper'

RSpec.describe JobsController, type: :controller do

  describe 'GET #search' do
    let(:gb_json){
      File.read(Rails.root.join('spec', 'fixtures', 'jobs_response.json'))
    }
    let(:parsed_gb_json) { JSON.parse(gb_json) }

    it 'returns http success' do
      get :search
      expect(response).to have_http_status(:success)
    end

    it 'returns a filtered json array decorated with favorites' do
      stub_response = Typhoeus::Response.new(code: 200, body: gb_json)
      Typhoeus.stub(/getonbrd/).and_return(stub_response)

      get :search, params: {q: 'react'}

      response_json = JSON.parse(response.body)
      decorated_parsed_json = parsed_gb_json['jobs'].map do |job|
        job.merge('favorite' => false)
      end

      expect(response_json['jobs']).to eq decorated_parsed_json
    end

    context 'when given an user email with favorites' do
      let(:user_email) { Faker::Internet.email }

      it 'returns the json array decorated with favorite status' do
        stub_response = Typhoeus::Response.new(code: 200, body: gb_json)
        Typhoeus.stub(/getonbrd/).and_return(stub_response)
        favorite = create(:favorite, job_id: parsed_gb_json['jobs'][0]['id'], email: user_email)

        get :search, params: {q: 'react', email: user_email}

        response_json = JSON.parse(response.body)
        favorite_jobs = response_json['jobs'].select{ |job| job['favorite'] }

        expect(favorite_jobs.length).to eq 1
        expect(favorite_jobs[0]['id']).to eq favorite.job_id
      end
    end
  end

end
