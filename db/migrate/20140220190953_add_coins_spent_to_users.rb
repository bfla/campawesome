class AddCoinsSpentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coins_spent, :integer
  end
end
