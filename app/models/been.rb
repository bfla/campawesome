class Been < ActiveRecord::Base
  belongs_to :beenable, polymorphic:true
  belongs_to :user
end
