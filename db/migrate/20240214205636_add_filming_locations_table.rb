class AddFilmingLocationsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :filming_locations do |t|
      t.string :country
      t.string :location
      t.references :movie, foreign_key: true

      t.index [:country, :location, :movie_id], unique: true
    end
  end
end
