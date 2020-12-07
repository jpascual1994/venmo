class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :user_a, class_name: 'User'
      t.belongs_to :user_b, class_name: 'User'
      t.timestamps
    end
  end
end
