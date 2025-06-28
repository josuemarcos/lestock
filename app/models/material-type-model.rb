class MaterialType < ActiveRecord::Base 
  validates :name, presence: true, uniqueness: true


  #Business Logic Methods
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
end