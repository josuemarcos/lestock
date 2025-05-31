require_relative 'suppliers-model'
class Material < ActiveRecord::Base
  validates :name, presence: true
  validates :supplier, presence: true
  validates :supplier_id, presence: true #, inclusion: {in: Supplier.pluck(:id)} Assure that the material will only be created with a supplier saved in the DB
  belongs_to :supplier
end