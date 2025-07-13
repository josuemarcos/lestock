class Material < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :material_type

end