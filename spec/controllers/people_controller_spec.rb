require 'rails_helper'

RSpec.describe 'PeopleController', :type => :controller do
  describe "GET index" do
    before(:each) do
      @controller = PeopleController.new
      allow(PersonQueryObject).to receive(:all).and_return({graph: PEOPLE_GRAPH, hierarchy: PEOPLE_HASH })
    end
    it 'can render data in json format' do
      get 'index', format: :json
      body = JSON.parse(response.body)

      expect(response.content_type).to eq 'application/json'
      expect(body["people"][0]["id"]).to eq '1'
    end

    it 'can render data in xml format' do
      get 'index', format: :xml
      body = Nokogiri.parse(response.body)
      p body.attribute
      expect(response.content_type).to eq 'application/xml'
      expect(body["people"][0]["id"]).to eq '1'
    end

    xit 'can render data in rdf format' do
      get 'index', format: :json
      body = JSON.parse(response.body)

      expect(response.content_type).to eq 'application/json'
      expect(body["people"][0]["id"]).to eq '1'
    end

    xit 'can does not render data in html format' do
      get 'index', format: :json
      body = JSON.parse(response.body)

      expect(response.content_type).to eq 'application/json'
      expect(body["people"][0]["id"]).to eq '1'
    end
  end

  #further tests to check formats - xml, rdf and html (which should not render) will follow
end
