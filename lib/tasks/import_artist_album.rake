require 'csv'

namespace :import do
  desc "Import artist name, album image, and album url from CSV"
  task artist_album: :environment do
    file_path = "db/csv/artist_album.csv"

    if File.exist?(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        artist_name = row["Artist Name"]
        album_image = row["Album Image"]
        album_url = row["Album URL"]

        # データベースにアーティスト情報を保存または更新
        artist = Artist.find_by(name: artist_name)
        
        if artist
          artist.update(album_image: album_image, album_url: album_url)
        else
          Artist.create(name: artist_name, album_image: album_image, album_url: album_url)
        end
      end

      puts "Imported artists data from #{file_path}"
    else
      puts "#{file_path} does not exist."
    end
  end
end
