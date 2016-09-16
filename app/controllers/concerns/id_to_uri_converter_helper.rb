module IdToUriConverterHelper
  def convert_id_to_resource_uri(id)
    "http://id.ukpds.org/#{id}"
  end
end