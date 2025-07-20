class Material < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :material_type

  validates :supplier, presence: { message: "must be a valid existing supplier" }, if: -> {supplier_id.present?}
  validates :supplier_id, presence: { message: "is required" }

  validates :material_type, presence: { message: "must be a valid existing material type" }, if: -> {material_type_id.present?}
  validates :material_type_id, presence: { message: "is required" }

  validates :material_type_id, uniqueness: {
    scope: :supplier_id,
    message: "is already registered for this supplier!"
  }

end