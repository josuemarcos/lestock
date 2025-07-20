class MaterialType < ActiveRecord::Base 
  validates :name, presence: true, uniqueness: true
  has_many :materials, dependent: :destroy
end