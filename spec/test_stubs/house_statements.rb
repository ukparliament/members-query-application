HOUSE_STATEMENTS = [
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/house/1'), RDF::URI.new('http://www.w3.org/2000/01/rdf-schema#label'), 'Commons'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/house/2'), RDF::URI.new('http://www.w3.org/2000/01/rdf-schema#label'), 'Lords'),
]

HOUSE_ARRAY = [
    { id: '1',
      label: 'Commons'
    },
    { id: '2',
      label: 'Lords'
    }
]