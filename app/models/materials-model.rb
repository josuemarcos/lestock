class Material < ActiveRecord::Base
  validates :name, presence: true
  validates :supplier, presence: true
end