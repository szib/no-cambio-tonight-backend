class Api::V1::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    render json: @categories, adapter: :json, root: 'categories'
  end
  

end
