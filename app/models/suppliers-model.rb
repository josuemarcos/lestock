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
      {data: supplier, ok: true}
    else
      {msg: "Supplier not found!", ok: false}
    end
  end

  def create_supplier(supplier)
    new_supplier = Supplier.new(supplier)
    return {msg: "#{new_supplier.errors.full_messages}", ok: false} unless new_supplier.valid?
    new_supplier.save
    {data: new_supplier, ok: true}
  end

  def update_supplier(id, attributes)
    supplier = Supplier.find_by(id:id)
    if supplier
      return {msg: "#{supplier.errors.full_messages}", ok: true} unless supplier.update(attributes)
      {data: supplier, ok: true}
    else
      {msg: "Supplier not found!", ok: false}
    end
  end

  def delete_supplier(id) 
    supplier = Supplier.find_by(id:id)
    if supplier
      supplier.destroy
      {msg: "Supplier deleted!", ok: true}
    else
      {msg: "Supplier not found!", ok: false}
    end
  end
end

