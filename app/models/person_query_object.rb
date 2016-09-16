class PersonQueryObject
  extend QueryObject

  def self.all
    result = self.query('
			PREFIX schema: <http://schema.org/>
			CONSTRUCT {
				?person
					schema:name ?name .
			}
			WHERE {
				?person
					a schema:Person ;
					schema:name ?name .
			}')

    people = self.single_statement_mapper(result, Schema.name, :name)

    hierarchy = {
        people: people
    }

    { graph: result, hierarchy: hierarchy }
  end

  def self.find(uri)
    result = self.query("
			PREFIX schema: <http://schema.org/>
			CONSTRUCT {
				<#{uri}>
					schema:name ?name .
			}
			WHERE {
				?person
					a schema:Person ;
					schema:name ?name .
			}
    ")

    # person[:house] = self.single_statement_mapper(graph, Rdfs.label, :label)
    # person[:constituency] = self.single_statement_mapper(graph, Parl.constituencyLabel, :label)

    # keeping the two lines above as a reminder of how this could work when there is more data

    people = self.single_statement_mapper(result, Schema.name, :name)

    hierarchy = {
        people: people
    }

    { :graph => result, :hierarchy => hierarchy }

  end
end