class CreateLikeRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :like_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    add_index :like_relationships, [:user_id, :post_id], unique: true
  end
end
