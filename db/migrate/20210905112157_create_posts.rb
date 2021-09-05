class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, :created_at
    add_index :posts, [:user_id, :created_at]
    remove_index :posts, :user_id
  end
end
