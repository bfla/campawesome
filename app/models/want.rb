class Want < ActiveRecord::Base
  belongs_to :campsite
  belongs_to :user
end