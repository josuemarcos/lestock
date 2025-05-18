require 'sinatra'
require_relative '../controllers/materials-controller'

class MaterialRouter < Sinatra::Base

  def initialize
    super
    @materials_controller = MaterialController.new
  end

  get '/' do
    @materials_controller.get_all_materials
  end
  
  get '/:id' do
    res = @materials_controller.get_material_by_id(params[:id])
    status res[:status].to_json
    return res[:response].to_json
  end
end



