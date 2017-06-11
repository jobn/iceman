class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|

      t.timestamps
    end

    add_column :users, :account_id, :integer
    add_index :users, :account_id
  end
end
