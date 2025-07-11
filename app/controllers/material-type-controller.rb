require 'sinatra'
require_relative '../services/material-type-service'

class MaterialTypeController < Sinatra::Base
  def initialize
    super
    @material_type_service = MaterialTypeService.new
  end

  before do
    content_type :json
  end

  get '/' do
    res = @material_type_service.get_all_material_types(params)
    return res[:data].to_json
  end

  get '/:id' do
    res = @material_type_service.get_material_type_by_id(params[:id])
    if res[:ok]
      status 200
      {material_type: res[:data]}.to_json
    else
      status 404
      {msg: res[:msg]}.to_json
    end
  end

  post '/' do
    payload = JSON.parse(request.body.read)
    res = @material_type_service.create_material_type(payload)
    if res[:ok]
      status 201
      {material_type: res[:data]}.to_json
    else
      status 422
      {msg: res[:msg]}.to_json
    end
  end

  patch '/:id' do
    payload = JSON.parse(request.body.read)
    res = @material_type_service.update_material_type(params[:id], payload)
    if res[:ok]
      if res[:data]
        status 200
        {material_type: res[:data]}.to_json
      else
        status 422
        {msg: res[:msg]}.to_json
      end
    else
      status 404
      {msg: res[:msg]}.to_json
    end
  end

  delete '/:id' do
    res = @material_type_service.delete_material_type(params[:id])
    if res[:ok]
      status 200
      {msg: res[:msg]}.to_json
    else
      status 404
      {msg: res[:msg]}.to_json
    end
  end

end