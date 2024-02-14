class AddMoviesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.text :description
      t.integer :year
      t.string :director
      t.timestamps

      #indexes
      t.index :year
      t.index :name, unique: true
    end
  end
end
