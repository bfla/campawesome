class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :type
      t.boolean :important
      t.boolean :red_flag

      t.timestamps
    end
  end
end
