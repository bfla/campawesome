class CreateCampsites < ActiveRecord::Migration
  def change
    create_table :campsites do |t|
      t.string :name
      t.text :description
      t.string :org
      t.string :res_phone
      t.string :camp_phone
      t.string :res_url
      t.string :camp_url

      t.timestamps
    end
  end
end
