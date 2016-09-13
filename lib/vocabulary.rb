module Vocabulary

  class Skos
    @@prefix = 'http://www.w3.org/2004/02/skos/core#'

  end

  class Parl
    @@prefix = 'http://data.parliament.uk/schema/parl#'

    def self.constituencyLabel
      RDF::URI.new("#{@@prefix}constituencyLabel")
    end

    def self.indexed
      RDF::URI.new("#{@@prefix}indexed")
    end
  end

  class Schema
    @@prefix = 'http://schema.org/'

    def self.name
      RDF::URI.new("#{@@prefix}name")
    end
  end

  class Rdfs
    @@prefix = 'http://www.w3.org/2000/01/rdf-schema#'

    def self.label
      RDF::URI.new("#{@@prefix}label")
    end
  end

end