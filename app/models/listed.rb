class Listed < ActiveRecord::Base
  belongs_to :campsite
  belongs_to :list
end
