class Api::V1::MechanicsController < ApplicationController

  def index
    @mechanics = Mechanic.all
    render json: @mechanics, adapter: :json, root: 'mechanics'
  end

end
