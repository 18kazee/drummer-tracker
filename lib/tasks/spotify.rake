namespace :spotify do
  desc "Update artist album image and url"
  task update_album_data: :environment do
    counter = 0

    Artist.all.find_each do |artist|
      spotify_artist = RSpotify::Artist.find(artist.spotify_id)

      if spotify_artist.present?
        album = spotify_artist.albums.first

        if album.present?
          image = album.images[1]
          artist.update(album_image: image["url"], album_url: album.external_urls['spotify'])
          counter += 1

          # Output the completed artist's name
          puts "Updated: #{artist.name}"

          if counter >= 30
            sleep 60 # 1 minute sleep after 10 requests
            counter = 0
          end
        else
          puts "No album found for #{artist.name}"
        end
      else
        puts "No artist found for #{artist.name}"
      end
    end
  end
end
