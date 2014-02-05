class Been < ActiveRecord::Base
  belongs_to: :campsite, dependent: :destroy
  belongs_to: :user, dependent: :destroy
end
