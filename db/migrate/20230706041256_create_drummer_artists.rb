class CreateDrummerArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :drummer_artists do |t|
      t.references :drummer, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end

    add_index :drummer_artists, [:drummer_id, :artist_id], unique: true
  end
end
