class AddAlbumImageAndAlbumUrlToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :album_image, :string
    add_column :artists, :album_url, :string
  end
end
