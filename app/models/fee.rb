class Fee < ActiveRecord::Base
  belongs_to :campsite
  validates :campsite, presence:true

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) { |row| Fee.create! row.to_hash }
  end

end
