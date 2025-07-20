require 'sinatra'
require_relative '../services/material-service'

class MaterialController < Sinatra::Base
  def initialize
    super
    @material_service = MaterialService.new
  end

  before do
    content_type :json
  end

  get '/' do
    res = @material_service.get_all_materials(params)
    return res[:data].to_json
  end

  get '/:id' do
    res = @material_service.get_material_by_id(params[:id])
    if res[:ok]
      status 200
      {material: res[:data]}.to_json
    else
      status 404
      {msg: res[:msg]}.to_json
    end
  end

  post '/' do
    payload = JSON.parse(request.body.read)
    res = @material_service.create_material(payload)
    if res[:ok]
      status 201
      {material: res[:data]}.to_json
    else
      status 422
      {msg: res[:msg]}.to_json
    end
  end
end