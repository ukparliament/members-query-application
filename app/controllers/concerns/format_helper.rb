module FormatHelper
  def format(data)
    respond_to do |format|
      format.any(:xml, :json) { render request.format.to_sym => data[:hierarchy] }

      format.rdf {
        result = ""
        data[:graph].each_statement do |statement|
          result << RDF::NTriples::Writer.serialize(statement)
        end

        render :text => result
      }
    end
  end
end