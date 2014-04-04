class Been < ActiveRecord::Base
  belongs_to :beenable, polymorphic:true
  belongs_to :user, counter_cache: :beens_count
end
