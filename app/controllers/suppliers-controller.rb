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
end