class AddReviewsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :stars
      t.string :user
      t.references :movies, foreign_key: true
      t.timestamps
    end
  end
end
