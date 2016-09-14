class PeopleController < ApplicationController
  include FormatHelper

  def index
    data = Person.all
    format(data)
  end

  def show
    data = Person.find(params[:id])
    format(data)
  end

end