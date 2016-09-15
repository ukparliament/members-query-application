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

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'
      expect(body["people"][0]["id"]).to eq '1'
    end

    it 'can render data in xml format' do
      get 'index', format: :xml

      body = Nokogiri::XML(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/xml'
      expect(body.xpath("//person")[0].children.children[0].content).to eq '1'
    end

    it 'can render data in rdf format' do
      get 'index', format: :rdf

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/rdf+xml'
    end

    it 'can does not render data in html format' do
      get 'index', format: :html

      #we need to think about the required behaviour here - at the moment it gives and unknown format error
      expect(response.status).to eq 'not sure yet'
    end
  end

  #further tests to check formats - xml, rdf and html (which should not render) will follow
end
