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
end