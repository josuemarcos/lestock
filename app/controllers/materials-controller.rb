require 'sinatra/base'
require_relative '../models/materials-model'


class MaterialController
  def get_all_materials(parameters)
    result = Material.all
    material = Material.where(name: parameters[:name]).or(Material.where(supplier: parameters[:supplier]))
    if parameters[:name] || parameters[:supplier]
      return {data: "Material not found!", status: 404} if material.empty?
      return {data: material, status: 200}
    else
      return {data: "No materials found!", status: 200} unless result
      return {data: "Wrong query parameter passed!", status: 400} unless parameters.empty?
      return {data: result, status: 200}
    end
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
    registered_name = new_attributes['name'] || material.name
    registered_supplier = new_attributes['supplier'] || material.supplier
    registered_material = Material.find_by(name: registered_name, supplier: registered_supplier)  #Verify if there's a material with the name and supplier passed saved on the DB

    if material
      return {msg: "This material is already registered!", status: 422} if registered_material && registered_material != material
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