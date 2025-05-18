require 'sinatra/base'
require_relative '../models/materials-model'


class MaterialController
  def get_all_materials
    result = Material.all

    if result.empty?
      {ok: false}
      return {msg: "No materials found!"}.to_json
    else
      return {materials: result}.to_json
    end
  end

  def get_material_by_id(id)
    result = Material.find_by(id: id)

    if result
      {ok: true, response: result, status: 200}
    else
      {ok: false, response: "couldn't find material with id: #{id}", status: 404}
    end
  rescue StandardError => error
    { ok: false}
    return {msg:   "Error: #{error.message}"}.to_json
  end
end