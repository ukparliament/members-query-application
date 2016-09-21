PERSON_STATEMENTS = [
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/1'), RDF::URI.new('http://schema.org/name'), 'Member1'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/2'), RDF::URI.new('http://schema.org/name'), 'Member2'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/3'), RDF::URI.new('http://schema.org/name'), 'Member3'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/4'), RDF::URI.new('http://schema.org/name'), 'Member4'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/5'), RDF::URI.new('http://schema.org/name'), 'Member5'),
]

LORD_ABERDARE_STATEMENT = RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00003468-0000-0000-0000-000000000001'), RDF::URI.new('http://schema.org/name'), 'Lord Aberdare')
SECOND_LORD_ABERDARE_STATEMENT = RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00003898-0000-0000-0000-000000000001'), RDF::URI.new('http://schema.org/name'), 'Lord Aberdare')
BARONESS_ADAMS_STATEMENT = RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/00000631-0000-0000-0000-000000000001'), RDF::URI.new('http://schema.org/name'), 'Baroness Adams of Craigielea')

PEOPLE_GRAPH = RDF::Graph.new
PERSON_STATEMENTS.each do |statement|
    PEOPLE_GRAPH << statement
end

PERSON_ONE_GRAPH = RDF::Graph.new
PERSON_ONE_GRAPH << PERSON_STATEMENTS[0]

LORD_ABERDARE_GRAPH = RDF::Graph.new
LORD_ABERDARE_GRAPH << LORD_ABERDARE_STATEMENT

PEOPLE_HASH = { people: [
    { id: '1',
      name: 'Member1'
    },
    { id: '2',
      name: 'Member2'
    },
    { id: '3',
      name: 'Member3'
    },
    { id: '4',
      name: 'Member4'
    },
    { id: '5',
      name: 'Member5'
    }
] }



PERSON_ONE_HASH = { people: [
    { id: '1',
      name: 'Member1'
    }
] }

LORD_ABERDARE_HASH = { people: [
    { id: '00003468-0000-0000-0000-000000000001',
      name: 'Lord Aberdare'
    }
] }

VCR_PEOPLE_ARRAY = [
    { id: '00003468-0000-0000-0000-000000000001',
      name: 'Lord Aberdare'
    },
    { id: '00003898-0000-0000-0000-000000000001',
      name: 'Lord Aberdare'
    },
    { id: '00000631-0000-0000-0000-000000000001',
      name: 'Baroness Adams of Craigielea'
    }
]
