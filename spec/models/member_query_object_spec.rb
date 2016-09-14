require 'rails_helper'
require 'test_stubs/person_statements'

describe 'PersonQueryObject' do
  xdescribe '#all' do
    before(:each) do
      stub_request(:post, "http://13.95.91.76/repositories/DataDriven").
        with(:headers => {'Accept'=>'text/turtle, text/rdf+turtle, application/turtle, application/x-turtle, application/n-triples, text/plain, */*;p=0.1', 'Connection'=>'keep-alive', 'Content-Type'=>'application/x-www-form-urlencoded', 'Keep-Alive'=>'120', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => MEMBER_STATEMENTS, :headers => {})
    end

    it 'returns a hash containing a graph of all member data' do
      result_hash = PersonQueryObject.all
      result_graph = RDF::Graph.new
      MEMBER_STATEMENTS.each do |statement|
        result_graph << statement
      end
      expect(result_hash[:graph]).to eq result_graph
    end

    it 'returns a hash containing an array of member hashes' do
      result_hash = PersonQueryObject.all
      expect(result_hash[:hierarchy]).to eq MEMBER_ARRAY
    end
  end

end