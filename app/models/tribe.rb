class Tribe < ActiveRecord::Base
  validates :name, :description, :vibe, presence: true
end
