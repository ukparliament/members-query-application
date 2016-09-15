class PeopleController < ApplicationController
  include FormatHelper

  def index
    data = PersonQueryObject.all
    format(data)
  end

  def show
    data = PersonQueryObject.find(params[:id])
    format(data)
  end

end