class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable, polymorphic: true
  belongs_to :review
  validates :user, presence: true
  validates :value, numericality: {greater_than_or_equal:1.0, less_than_or_equal_to:5.0}
  after_save :store_campsite_avg

  private
    def store_campsite_avg
      if self.ratable_type == "Campsite"
        sum = 0
        self.ratable.ratings.each {|rating| sum = sum + rating.value}
        self.ratable.avg_rating = sum / self.ratable.ratings.size
      end
    end
end
