class Vibe < ActiveRecord::Base
  belongs_to :tribe
  belongs_to :campsite

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) { |row| Vibe.create! row.to_hash }
  end
  
end
