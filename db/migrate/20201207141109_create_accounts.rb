class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.float :balance, null: false, default: 0
      t.belongs_to :user
      t.timestamps
    end
  end
end
