class SupplierController
  def get_all_suppliers(params)
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
end