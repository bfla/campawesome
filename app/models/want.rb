class Want < ActiveRecord::Base
  belongs_to :wantable, polymorphic:true
  belongs_to :user
end
