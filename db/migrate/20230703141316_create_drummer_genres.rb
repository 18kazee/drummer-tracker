class CreateDrummerGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :drummer_genres do |t|
      t.references :drummer, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end

    add_index :drummer_genres, [:drummer_id, :genre_id], unique: true
  end
end
