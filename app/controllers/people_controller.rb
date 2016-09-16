class PeopleController < ApplicationController
  include FormatHelper
  include IdToUriConverterHelper

  def index
    data = PersonQueryObject.all
    format(data)
  end

  def show
    uri = convert_id_to_resource_uri(params[:id])
    data = PersonQueryObject.find(uri)
    format(data)
  end

end