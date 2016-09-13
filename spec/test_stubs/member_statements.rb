MEMBER_STATEMENTS = [
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/1'), RDF::URI.new('http://schema.org/name'), 'Member1'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/2'), RDF::URI.new('http://schema.org/name'), 'Member2'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/3'), RDF::URI.new('http://schema.org/name'), 'Member3'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/4'), RDF::URI.new('http://schema.org/name'), 'Member4'),
    RDF::Statement.new(RDF::URI.new('http://id.ukpds.org/member/5'), RDF::URI.new('http://schema.org/name'), 'Member5'),
]

MEMBER_ARRAY = [
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
]