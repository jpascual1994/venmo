class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.belongs_to :sender, class_name: 'User'
      t.belongs_to :receiver, class_name: 'User'
      t.float :amount, null: false
      t.text :description, null: false, default: ''

      t.timestamps
    end
  end
end
