class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :campsite
  belongs_to :user
  validates :tag, :campsite, presence:true

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) { |row| Tagging.create! row.to_hash }
  end

end
