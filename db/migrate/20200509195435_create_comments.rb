class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.references :post, null: false, foreign_key: {to_table: :posts}

      t.timestamps
    end
  end
end
