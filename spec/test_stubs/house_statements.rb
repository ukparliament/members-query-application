HOUSE_STATEMENTS = [
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00000000-0001-0000-0000-000000000000'), RDF::URI.new('http://www.w3.org/2000/01/rdf-schema#label'), 'House of Commons'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00000000-0002-0000-0000-000000000000'), RDF::URI.new('http://www.w3.org/2000/01/rdf-schema#label'), 'House of Lords'),
]

HOUSE_GRAPH = RDF::Graph.new
HOUSE_STATEMENTS.each do |statement|
  HOUSE_GRAPH << statement
end

HOUSE_ARRAY = [
    { id: '00000000-0001-0000-0000-000000000000',
      label: 'House of Commons'
    },
    { id: '00000000-0002-0000-0000-000000000000',
      label: 'House of Lords'
    }
]