class AddUserIndexBasedOnUsername < ActiveRecord::Migration[5.0]
  def change
        add_index :users, :username
  end
end
