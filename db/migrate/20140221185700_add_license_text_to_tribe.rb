class AddLicenseTextToTribe < ActiveRecord::Migration
  def change
    add_column :tribes, :license_text, :string
  end
end
