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

end