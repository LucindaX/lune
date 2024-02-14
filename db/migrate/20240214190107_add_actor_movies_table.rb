class AddActorMoviesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :actor_movies do |t|
      t.references :actor, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.index [:actor_id, :movie_id], unique: true
    end
  end
end
