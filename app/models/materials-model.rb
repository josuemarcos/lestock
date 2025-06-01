class Material < ActiveRecord::Base
  validates :name, presence: true
  validates :supplier_id, presence: true
  belongs_to :supplier
end