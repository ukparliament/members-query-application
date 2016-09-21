LORD_ABERDARE_STATEMENT = RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00003468-0000-0000-0000-000000000001'), RDF::URI.new('http://schema.org/name'), 'Lord Aberdare')
SECOND_LORD_ABERDARE_STATEMENT = RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00003898-0000-0000-0000-000000000001'), RDF::URI.new('http://schema.org/name'), 'Lord Aberdare')
BARONESS_ADAMS_STATEMENT = RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00000631-0000-0000-0000-000000000001'), RDF::URI.new('http://schema.org/name'), 'Baroness Adams of Craigielea')

PERSON_STATEMENTS = [
    LORD_ABERDARE_STATEMENT,
    SECOND_LORD_ABERDARE_STATEMENT,
    BARONESS_ADAMS_STATEMENT
]

PEOPLE_GRAPH = RDF::Graph.new
PERSON_STATEMENTS.each do |statement|
    PEOPLE_GRAPH << statement
end

LORD_ABERDARE_GRAPH = RDF::Graph.new
LORD_ABERDARE_GRAPH << LORD_ABERDARE_STATEMENT

PEOPLE_HASH = { people: [
    { id: '00003468-0000-0000-0000-000000000001',
      name: 'Lord Aberdare'
    },
    { id: '00003898-0000-0000-0000-000000000001',
      name: 'Lord Aberdare'
    },
    { id: '00000631-0000-0000-0000-000000000001',
      name: 'Baroness Adams of Craigielea'
    }
] }

LORD_ABERDARE_HASH = { people: [
    { id: '00003468-0000-0000-0000-000000000001',
      name: 'Lord Aberdare'
    }
] }
