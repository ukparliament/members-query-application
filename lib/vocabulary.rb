module Vocabulary
  class Skos
    @@prefix = 'http://www.w3.org/2004/02/skos/core#'

    def self.prefLabel
      RDF::URI.new("#{@@prefix}prefLabel")
    end

    def self.Concept
      RDF::URI.new("#{@@prefix}Concept")
    end
  end
end