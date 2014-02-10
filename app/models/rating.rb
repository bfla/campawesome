class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable, polymorphic: true
  validates :user, presence: true
  validates :value, numericality: {greater_than:0, less_than_or_equal_to:5.0}
end
