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

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/xml'
    end

    it 'can render data in rdf format' do
      get 'index', format: :rdf

      first_statement = nil
      RDF::NTriples::Reader.new(response.body) do |reader|
        first_statement = reader.first
      end
      expected_statement = RDF::Statement(RDF::URI.new("http://id.ukpds.org/member/1"), Schema.name, "Member1")
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/rdf+xml'
      expect(first_statement).to eq expected_statement
    end

    it 'can does not render data in html format' do
      expect{ get 'index', format: :html }.to raise_error(ActionController::UnknownFormat)
    end
  end

  #further tests to check formats - xml, rdf and html (which should not render) will follow
end
