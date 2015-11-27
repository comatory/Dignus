class ApiController < ApplicationController
  def search
    results = Search.search(params[:query])
    render json: results
  end
end
