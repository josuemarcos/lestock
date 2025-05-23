require 'sinatra/base'
require_relative '../models/materials-model'


class MaterialController
  def get_all_materials
    result = Material.all
    return {msg: "No materials found!"}.to_json unless result
    return {materials: result}.to_json
  end

  def get_material_by_id(id)
    result = Material.find_by(id: id)
    return {data: "Material not found!", status: 404} unless result
    {data: result, status: 200}
  end

  def create_material(material)
    check_material = Material.find_by(name: material['name'], supplier: material['supplier'])
    if check_material
      {msg: "This material already exist!", data: check_material, status: 422}
    else
      new_material = Material.new(material)
      return {msg: "#{new_material.errors.full_messages}", status: 422} unless new_material.valid?
      new_material.save
      {msg: "Material created!", data: new_material, status: 201}
    end
  end

  def update_material(id, new_attributes)
    material = Material.find_by(id: id)
    if material
      return {msg: "#{material.errors.full_messages}", status: 422} unless material.update(new_attributes)
      {msg: "Material updated!", data: material, status: 200}
    else
      {msg: "Material not found!", status: 404}
    end
  end

  def delete_material(id)
    material = Material.find_by(id: id)
    return {msg: "Material not found!", status: 404} unless material
    material.destroy
    {msg: "Material Deleted!", status: 200}
  end
end