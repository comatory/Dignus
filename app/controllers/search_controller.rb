class SearchController < ApplicationController
  def index
    @results = []
  end

  def create
    @results = Search.search(params[:query])
    render :index 
  end
end
