class Supplier < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  #Business Logic Methods
  def get_all_suppliers(params = {})
    params[:name] ? result = Supplier.where(
      "name LIKE ?", "%" + Supplier.sanitize_sql_like(params[:name]) + "%"
    ) : result = Supplier.all 
    if result.empty?
      {data: "No suppliers registered!"}
    else
      {data: result}
    end
  end

  def get_supplier_by_id(id)
    supplier = Supplier.find_by(id: id)
    if supplier
      {data: supplier, status: 200}
    else
      {data: "Supplier not found!", status: 404}
    end
  end

  def create_supplier(supplier)
    new_supplier = Supplier.new(supplier)
    return {msg: "#{new_supplier.errors.full_messages}", status: 422} unless new_supplier.valid?
    new_supplier.save
    {msg: "Supplier registered!", data: new_supplier, status: 201}
  end

  def update_supplier(id, attributes)
    supplier = Supplier.find_by(id:id)
    if supplier
      return {msg: "#{supplier.errors.full_messages}", status: 422} unless supplier.update(attributes)
      {msg: "Supplier updated!", data: supplier, status: 200}
    else
      {msg: "Supplier not found!", status: 404}
    end
  end

  def delete_supplier(id) 
    supplier = Supplier.find_by(id:id)
    if supplier
      supplier.destroy
      {msg: "Supplier deleted!", status: 200}
    else
      {msg: "Supplier not found!", status: 404}
    end
  end
end

