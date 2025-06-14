class SupplierController
  def get_all_suppliers(parameters)
    result = Supplier.all
    supplier = Supplier.where(name: parameters[:name])
    if parameters[:name] 
      return {data: "Supplier not found!", status: 404} if supplier.empty?
      return {data: supplier, status: 200}
    else
      return {data: "No suppliers found!", status: 200} unless result
      return {data: "Wrong query parameter passed!", status: 400} unless parameters.empty?
      return {data: result, status: 200}
    end
  end
end