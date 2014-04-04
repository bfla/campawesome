class Want < ActiveRecord::Base
  belongs_to :wantable, polymorphic:true
  belongs_to :user, counter_cache: :wants_count
end
