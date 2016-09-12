require 'spec_helper'
require 'vocabulary'
require 'query_object'
require 'rdf'
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

end