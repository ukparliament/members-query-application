require 'rails_helper'

describe 'PersonQueryObject' do
  describe '#all' do
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

    it 'returns a hash containing an hash of people' do
      result_hash = PersonQueryObject.all
      expect(result_hash[:hierarchy]).to eq PEOPLE_HASH
    end
  end

end