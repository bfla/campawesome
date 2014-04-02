class Activity < ActiveRecord::Base
  belongs_to :activity_type
  belongs_to :campsite
  belongs_to :user
  validates :activity_type, :campsite, :user, presence:true

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) { |row| Activity.create! row.to_hash }
  end

end
