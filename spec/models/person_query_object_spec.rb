require 'rails_helper'
require 'test_stubs/person_statements'

describe 'PersonQueryObject' do
  describe '#all' do
    before(:each) do
      stub_request(:post, "http://13.95.91.76/repositories/DataDriven").
          with(:body => {"query"=>"\n\t\t\tPREFIX schema: <http://schema.org/>\n\t\t\tCONSTRUCT {\n\t\t\t\t?person\n\t\t\t\t\tschema:name ?name .\n\t\t\t}\n\t\t\tWHERE {\n\t\t\t\t?person\n\t\t\t\t\ta schema:Person ;\n\t\t\t\t\tschema:name ?name .\n\t\t\t}"},
               :headers => {'Accept'=>'text/turtle, text/rdf+turtle, application/turtle, application/x-turtle, application/n-triples, text/plain, */*;p=0.1', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection'=>'keep-alive', 'Content-Type'=>'application/x-www-form-urlencoded', 'Keep-Alive'=>'120', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => PERSON_STATEMENTS, :headers => {})

    end

    it 'returns a hash containing a graph of all member data' do
      result_hash = PersonQueryObject.all
      result_graph = RDF::Graph.new
      PERSON_STATEMENTS.each do |statement|
        result_graph << statement
      end
      expect(result_hash[:graph]).to eq result_graph
    end

    it 'returns a hash containing an array of member hashes' do
      result_hash = PersonQueryObject.all
      expect(result_hash[:hierarchy]).to eq PERSON_ARRAY
    end
  end

end