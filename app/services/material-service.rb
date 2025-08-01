class MaterialService

  def get_all_materials(params = {})
    if params[:supplier_name]
      fetch_material_by_supplier(params[:supplier_name])
    elsif params[:material_type_name]
      fetch_material_by_type(params[:material_type_name])
    else
      fetch_all_materials
    end
  end

  def get_material_by_id(id)
    material = Material.find_by(id: id)
    if material
      {data: material, ok: true}
    else
      {msg: "Material not found!", ok: false}
    end
  end

  def create_material(material)
    new_material = Material.new(material)
    return {msg: "#{new_material.errors.full_messages}", ok: false} unless new_material.valid?
    new_material.save
    {data: new_material, ok: true}
  end



 

  



  private

  def fetch_material_by_supplier(supplier_name)
    suppliers = Supplier.where(
      "name LIKE ?", "%" + Supplier.sanitize_sql_like(supplier_name) + "%"
    )
    result = []
    suppliers.each do |supplier|
      material = Material.where(supplier_id: supplier[:id])
      result.push(material) unless material.empty?
    end

    if result.empty?
      {data: "No materials registered!"}
    else
      {data: result}
    end
  end

  def fetch_material_by_type(material_type_name)
    material_types = MaterialType.where(
      "name LIKE ?", "%" + MaterialType.sanitize_sql_like(material_type_name) + "%"
    )
    result = []
    material_types.each do |material_type|
      material = Material.where(material_type_id: material_type[:id])
      result.push(material) unless material.empty?
    end

    if result.empty?
      {data: "No materials registered!"}
    else
      {data: result}
    end
  end

  def fetch_all_materials
    result = Material.all
    if result.empty?
      {data: "No material types registered!"}
    else
      {data: result}
    end
  end







end