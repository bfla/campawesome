class List < ActiveRecord::Base
  belongs_to :user, counter_cache: :lists_count
  has_many :listeds, dependent: :destroy
  has_many :listables, through: :listeds

end
