module QueryObject
  include Vocabulary

  def query(sparql)
    RDF::Graph.new << SPARQL::Client.new(MembersQueryApplication::Application.config.database).query(sparql)
  end

  def get_id(uri)
    uri.to_s.split("/").last
  end

  def get_object(graph, subject, predicate)
    pattern = RDF::Query::Pattern.new(
        subject,
        predicate,
        :object)
    graph.first_object(pattern)
  end

  def map_people(graph)
    person_pattern = RDF::Query::Pattern.new(
        :subject,
        Schema.name,
        :name
    )
    graph.query(person_pattern).map do |statement|
      {
          id: get_id(statement.subject),
          name: statement.object.to_s
      }
    end
  end

  def map_houses(graph)
    house_pattern = RDF::Query::Pattern.new(
        :subject,
        Rdfs.label,
        :label
    )
    graph.query(house_pattern).map do |statement|
      {
          id: get_id(statement.subject),
          label: statement.object.to_s
      }
    end
  end

  def single_statement_mapper(graph, predicate, object)
    pattern = RDF::Query::Pattern.new(
        :subject,
        predicate,
        object
    )
    graph.query(pattern).map do |statement|
      {
          :id => get_id(statement.subject),
          object => statement.object.to_s
      }
    end
  end

end