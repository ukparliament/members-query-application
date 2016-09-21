require 'rails_helper'

describe 'PersonQueryObject' do
  describe '#all' do
    let(:result_hash) { PersonQueryObject.all }

    before(:each) do
      VCR.insert_cassette("people_all")
    end

    it 'returns a hash containing a graph with 4455 members' do
        expect(result_hash[:graph].count).to eq 4455
    end

    it 'returns a hash containing a graph where the first three people are correct' do
        expect(result_hash[:graph].first).to eq LORD_ABERDARE_STATEMENT
        result_hash[:graph].delete(LORD_ABERDARE_STATEMENT)
        expect(result_hash[:graph].first).to eq SECOND_LORD_ABERDARE_STATEMENT
        result_hash[:graph].delete(SECOND_LORD_ABERDARE_STATEMENT)
        expect(result_hash[:graph].first).to eq BARONESS_ADAMS_STATEMENT
    end

    it 'returns a hash containing a hierarchy hash of people' do
        expect(result_hash[:hierarchy][:people][0..2]).to eq PEOPLE_HASH[:people]
    end

    after(:each) do
      VCR.eject_cassette
    end
  end

  describe '#find' do
    let(:result_hash) { PersonQueryObject.find('http://id.ukpds.org/00003468-0000-0000-0000-000000000001') }

    before(:each) do
      VCR.insert_cassette("person_lord_aberdare")
    end

    it 'returns a hash containing a graph with a count of 1' do
        expect(result_hash[:graph].count).to eq 1
    end

    it 'returns a hash containing a graph with data for one person' do
        expect(result_hash[:graph]).to eq LORD_ABERDARE_GRAPH
    end

    it 'returns a hash containing a hierarchy hash for one person' do
        expect(result_hash[:hierarchy]).to eq LORD_ABERDARE_HASH
    end

    after(:each) do
      VCR.eject_cassette
    end
  end

end