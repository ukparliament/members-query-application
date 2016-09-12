require 'rails_helper'
require 'test_stubs/member_statements'

describe 'MemberQueryObject' do
  describe '#all' do
  before(:each) do
    stub_request(:post, "http://graphdbtest.eastus.cloudapp.azure.com/repositories/DataDriven06").
        with(:body => {"query"=>"\n\t\t\tPREFIX parl: <http://data.parliament.uk/schema/parl#>\n\t\t\tPREFIX schema: <http://schema.org/>\n\t\t\tCONSTRUCT {\n\t\t\t\t?person\n\t\t\t\t\tschema:name ?name .\n\t\t\t}\n\t\t\tWHERE {\n\t\t\t\t?person\n\t\t\t\t\ta schema:Person ;\n\t\t\t\t\tschema:name ?name .\n\t\t\t}"},
             :headers => {'Accept'=>'text/turtle, text/rdf+turtle, application/turtle, application/x-turtle, application/n-triples, text/plain, */*;p=0.1', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection'=>'keep-alive', 'Content-Type'=>'application/x-www-form-urlencoded', 'Keep-Alive'=>'120', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => MEMBER_STATEMENTS, :headers => {})

  end

    it 'returns a hash with a graph of all members and a hierarchy of all members' do
      result_hash = MemberQueryObject.all
      result_graph = RDF::Graph.new
      MEMBER_STATEMENTS.each do |statement|
        result_graph << statement
      end
      expect(result_hash[:graph]).to eq result_graph
    end
  end
end