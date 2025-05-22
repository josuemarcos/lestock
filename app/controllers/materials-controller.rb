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
      {ok: true, data: result, status: 200}
    else
      {ok: false, data: "Material not found!", status: 404}
    end
  rescue StandardError => error
    { ok: false}
    return {msg:   "Error: #{error.message}"}.to_json
  end

  def create_material(material)
    check_material = Material.find_by(name: material['name'], supplier: material['supplier'])
    if check_material
      {msg: "This material already exist!", data: check_material, status: 422}
    else
      new_material = Material.create(material)
      {msg: "Material created!", data: new_material, status: 201}
    end
    rescue StandardError => error
    { ok: false}
    return {msg:   "Error: #{error.message}"}.to_json
  end

  def update_material(id, new_attributes)
    material = Material.find_by(id: id)
    if material
      material.update(new_attributes)
      {msg: "Material updated!", data: material, status: 200}
    else
      {msg: "Material not found!", status: 404}
    end
    rescue StandardError => error
    { ok: false}
    return {msg:   "Error: #{error.message}"}.to_json
  end

  def delete_material(id)
    material = Material.find_by(id: id)
    if material
      material.destroy
      {msg: "Material Deleted!", status: 200}
    else
      {msg: "Material not found!", status: 404}
    end
  end
end