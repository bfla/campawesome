class State < ActiveRecord::Base
  # name:string
  has_many :campsites
end
