require 'spec_helper'
require 'query_object'
require 'test_stubs/member_statements'
require 'test_stubs/house_statements'

include Vocabulary

describe QueryObject do
  let(:extended_class) { Class.new { extend QueryObject }}

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
      predicate = Parl.indexed
      graph = RDF::Graph.new << RDF::Statement(subject, predicate, 'indexed')
      object = extended_class.get_object(graph, subject, predicate)
      expect(object).to eq 'indexed'
    end
  end

  describe '#map_people' do
    it 'returns an array of hashes each containing the properties of a person' do
      graph = RDF::Graph.new
      MEMBER_STATEMENTS.each do |statement|
        graph << statement
      end
      people = extended_class.map_people(graph)

      expect(people).to eq MEMBER_ARRAY
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
    it 'returns an array of hashes each containing the id and a property for the given graph and pattern' do
      graph = RDF::Graph.new
      HOUSE_STATEMENTS.each do |statement|
        graph << statement
      end
      houses = extended_class.single_statement_mapper(graph, Rdfs.label, :label)

      expect(houses).to eq HOUSE_ARRAY

    end
  end

end