class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable, polymorphic: true
  belongs_to :review
  validates :user, presence: true
  validates :value, numericality: {greater_than_or_equal:1.0, less_than_or_equal_to:5.0}
  #before_save :store_avg_rating

  #private
    #def store_avg_rating # save the average rating for the ratable object
      #sum = self.value
      #self.ratable.ratings.each {|rating| sum = sum + rating.value}
      #self.ratable.avg_rating = sum / self.ratable.ratings.size
    #end
end
