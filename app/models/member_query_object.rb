class MemberQueryObject
  extend QueryObject

  def self.all
    result = self.query('
			PREFIX parl: <http://data.parliament.uk/schema/parl#>
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

    people = self.map_people(graph.statements)

    hierarchy = {
        people: people
    }

    { graph: result, hierarchy: hierarchy }
  end
end