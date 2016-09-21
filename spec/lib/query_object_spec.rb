require 'rails_helper'
require 'query_object'
require 'test_stubs/person_statements'
require 'test_stubs/house_statements'

describe QueryObject do
  let(:extended_class) { Class.new { extend QueryObject }}

  describe '#query' do
    it 'returns a graph with the houses when the query requests them' do
      VCR.use_cassette("query_object") do
        graph = extended_class.query(
            'PREFIX parl: <http://data.parliament.uk/schema/parl#>
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            construct {
                ?house rdfs:label ?label
            } where {
              ?house a parl:House ;
                    rdfs:label ?label .
            }')
        expect(graph).to eq HOUSE_GRAPH
      end
    end
  end

  describe '#get_id' do
    it 'returns an id from a given uri' do
      uri = RDF::URI.new('http://id.test.com/123')
      id = extended_class.get_id(uri)
      expect(id).to eq '123'
    end
  end

  describe '#get_object' do
    it 'returns the first object from a pattern' do
      subject = RDF::URI.new("http://id.test.com/123")
      predicate = Vocabulary::Parl.indexed
      graph = RDF::Graph.new << RDF::Statement(subject, predicate, 'indexed')
      object = extended_class.get_object(graph, subject, predicate)
      expect(object).to eq 'indexed'
    end
  end

  describe '#map_people' do
    it 'returns an array of hashes each containing the properties of a person' do
      graph = RDF::Graph.new
      PERSON_STATEMENTS.each do |statement|
        graph << statement
      end
      people = extended_class.map_people(graph)

      expect(people).to eq PEOPLE_HASH[:people]
    end
  end

  describe '#map_house' do
    it 'returns an array of hashes each containing the properties of a house' do
      graph = RDF::Graph.new
      HOUSE_STATEMENTS.each do |statement|
        graph << statement
      end
      houses = extended_class.map_houses(graph)

      expect(houses).to eq HOUSE_ARRAY
    end
  end

  describe '#single_statement_mapper' do
    it 'returns an array of hashes each containing the id and a property for the given graph (for statements of same subject type) and pattern' do
      graph = RDF::Graph.new
      HOUSE_STATEMENTS.each do |statement|
        graph << statement
      end
      houses = extended_class.single_statement_mapper(graph, Vocabulary::Rdfs.label, :label)

      expect(houses).to eq HOUSE_ARRAY
    end

  end

end