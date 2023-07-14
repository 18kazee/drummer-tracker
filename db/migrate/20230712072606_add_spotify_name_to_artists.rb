class AddSpotifyNameToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :spotify_name, :string
  end
end
