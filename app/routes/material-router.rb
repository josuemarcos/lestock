require 'sinatra'
require_relative '../controllers/materials-controller'

class MaterialRouter < Sinatra::Base

  def initialize
    super
    @materials_controller = MaterialController.new
  end

  before do
    content_type :json
  end

  get '/' do
    @materials_controller.get_all_materials
  end
  
  get '/:id' do
    res = @materials_controller.get_material_by_id(params[:id])
    status res[:status].to_json
    return res[:data].to_json
  end

  post '/' do
    payload = JSON.parse(request.body.read)
    res = @materials_controller.create_material(payload)
    status res[:status].to_json
    return res[:msg].to_json, res[:data].to_json
  end

  patch '/:id' do
    payload = JSON.parse(request.body.read)
    res = @materials_controller.update_material(params[:id], payload)
    status res[:status].to_json
    return res[:msg].to_json, res[:data].to_json
  end

  delete '/:id' do
    res = @materials_controller.delete_material(params[:id])
    status res[:status].to_json
    return res[:msg].to_json
  end

end



