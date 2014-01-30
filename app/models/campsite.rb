class Campsite < ActiveRecord::Base
  belongs_to :state
  def state_name
    self.state.name if self.state.name?
  end
end
