module QueryObject
  include Vocabulary

  def query(sparql)
    RDF::Graph.new << SPARQL::Client.new(MembersQueryApplication::Application.config.database).query(sparql)
  end

  def get_id(uri)
    uri.to_s.split("/").last
  end

end