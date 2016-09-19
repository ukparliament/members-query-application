require 'rails_helper'

describe 'PersonQueryObject' do
  describe '#all' do
    let(:result_hash) { described_class.all }
    before(:each) do
      allow(PersonQueryObject).to receive(:query).with('
			PREFIX schema: <http://schema.org/>
			CONSTRUCT {
				?person
					schema:name ?name .
			}
			WHERE {
				?person
					a schema:Person ;
					schema:name ?name .
			}').and_return(PEOPLE_GRAPH)
    end

    it 'returns a hash containing a graph of all people data' do
      result_hash = PersonQueryObject.all
      expect(result_hash[:graph]).to eq PEOPLE_GRAPH
    end

    it 'returns a hash containing a hierarchy hash of people' do
      result_hash = PersonQueryObject.all
      expect(result_hash[:hierarchy]).to eq PEOPLE_HASH
    end
  end

  describe '#find' do
    before(:each) do
      allow(PersonQueryObject).to receive(:query).with("
			PREFIX schema: <http://schema.org/>
			CONSTRUCT {
				<http://id.ukpds.org/1>
					schema:name ?name .
			}
			WHERE {
				<http://id.ukpds.org/1>
					a schema:Person ;
					schema:name ?name .
			}").and_return(PERSON_ONE_GRAPH)
    end

    it 'returns a hash containing a graph with data for one person' do
      result_hash = PersonQueryObject.find('http://id.ukpds.org/1')
      expect(result_hash[:graph]).to eq PERSON_ONE_GRAPH
    end

    it 'returns a hash containing a hierarchy hash for one person' do
      result_hash = PersonQueryObject.find('http://id.ukpds.org/1')
      expect(result_hash[:hierarchy]).to eq PERSON_ONE_HASH
    end
  end

end