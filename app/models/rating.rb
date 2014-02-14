class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable, polymorphic: true
  belongs_to :review
  validates :user, presence: true
  validates :value, numericality: {greater_than_or_equal:1.0, less_than_or_equal_to:5.0}
end
