class MaterialTypeService
  def get_all_material_types(params = {})
    params[:name] ? result = MaterialType.where(
      "name LIKE ?", "%" + MaterialType.sanitize_sql_like(params[:name]) + "%"
    ) : result = MaterialType.all 
    if result.empty?
      {data: "No material types registered!"}
    else
      {data: result}
    end
  end

  def get_material_type_by_id(id)
    material_type = MaterialType.find_by(id: id)
    if material_type
      {data: material_type, ok: true}
    else
      {msg: "Material type not found!", ok: false}
    end
  end

  def create_material_type(material_type)
    new_material_type = MaterialType.new(material_type)
    return {msg: "#{new_material_type.errors.full_messages}", ok: false} unless new_material_type.valid?
    new_material_type.save
    {data: new_material_type, ok: true}
  end

  def update_material_type(id, attributes)
    material_type = MaterialType.find_by(id:id)
    if material_type
      return {msg: "#{material_type.errors.full_messages}", ok: true} unless material_type.update(attributes)
      {data: material_type, ok: true}
    else
      {msg: "Material type not found!", ok: false}
    end
  end

  def delete_material_type(id) 
    material_type = MaterialType.find_by(id:id)
    if material_type
      material_type.destroy
      {msg: "Material type deleted!", ok: true}
    else
      {msg: "Material type not found!", ok: false}
    end
  end
end