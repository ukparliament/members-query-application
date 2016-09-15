require 'rails_helper'

RSpec.describe 'PeopleController', :type => :controller do
  describe "GET index" do
    it 'can render data in json format' do
      get 'index', :format => :json

      body = JSON.parse(response.body)

      expect(response.content_type).to eq 'application/json'
      expect(body[:people][0][:id]).to eq '1'
    end
  end

  #further tests to check formats - xml, rdf and html (which should not render) will follow
end
