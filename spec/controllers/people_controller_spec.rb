require 'rails_helper'

RSpec.describe PeopleController, :type => :controller do
  let(:json) { JSON.parse(response.body) }
  let(:xml) { Nokogiri::XML(response.body) }
  let(:rdf) { RDF::NTriples::Reader.new(response.body) }

  describe 'GET index' do
    before(:each) do
      allow(PersonQueryObject).to receive(:all).and_return({graph: PEOPLE_GRAPH, hierarchy: PEOPLE_HASH })
    end

    context 'when the requested format is JSON' do
      before(:each) do
        get 'index', format: :json
      end
      it 'returns OK reponse with correct format' do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns the correct number of people in the graph' do
        expect(json['people'].length).to eq 5
      end

      it 'returns the correct id for the second person' do
        expect(json['people'][1]['id']).to eq '2'
      end
    end

    context 'when the requested format is XML' do
      before(:each) do
        get 'index', format: :xml
      end
      it 'returns OK reponse with correct format' do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/xml'
      end

      it 'returns the correct number of people in the graph' do
        expect(xml.xpath('//person').count).to eq 5
      end

      it 'returns the correct id for the second person' do
        expect(xml.xpath('//person')[1].children.children[0].content).to eq '2'
      end
    end

    context 'when the requested format is RDF' do
      before(:each) do
        get 'index', format: :rdf
      end
      it 'returns OK reponse with correct format' do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/rdf+xml'
      end

      it 'returns the correct number of people in the graph' do
        expect(rdf.count).to eq 5
      end

      it 'returns the correct data for the first person' do
        expect(rdf.first).to eq PERSON_STATEMENTS[0]
      end
    end

    context 'when the requested format is HTML' do
      it 'raises an unknown format error' do
        expect{ get 'index', format: :html }.to raise_error(ActionController::UnknownFormat)
      end
    end
  end

  describe "GET show" do
    before(:each) do
      allow(PersonQueryObject).to receive(:find).with('http://id.ukpds.org/members/1').and_return({graph: PERSON_ONE_GRAPH, hierarchy: PERSON_ONE_HASH })
    end

    context 'when the requested format is JSON' do
      before(:each) do
        get 'show', id: 'members/1', format: :json
      end
      it 'returns OK reponse with correct format' do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns only one person in the graph' do
        expect(json['people'].length).to eq 1
      end

      it 'returns the correct id for the person' do
        expect(json['people'][0]['id']).to eq '1'
      end
    end

    context 'when the requested format is XML' do
      before(:each) do
        get 'show', id: 'members/1', format: :xml
      end
      it 'returns OK reponse with correct format' do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/xml'
      end

      it 'returns only one person in the graph' do
        expect(xml.xpath('//person').count).to eq 1
      end

      it 'returns the correct id for the person' do
        expect(xml.xpath('//person')[0].children.children[0].content).to eq '1'
      end
    end

    context 'when the requested format is RDF' do
      before(:each) do
        get 'show', id: 'members/1', format: :rdf
      end
      it 'returns OK reponse with correct format' do
        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/rdf+xml'
      end

      it 'returns only one person in the graph' do
        expect(rdf.count).to eq 1
      end

      it 'returns the correct data for the person' do
        expect(rdf.first).to eq PERSON_STATEMENTS[0]
      end
    end

    context 'when the requested format is HTML' do
      it 'raises an unknown format error' do
        expect{ get 'show', id: 'members/1', format: :html }.to raise_error(ActionController::UnknownFormat)
      end
    end
  end

end
