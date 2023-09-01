require 'csv'

namespace :import_artist do
  desc 'Import drummers from CSV'
  task artists: :environment do
    csv_file_path = 'db/csv/artists.csv'  # CSVファイルのパスを指定してください

    CSV.foreach(csv_file_path, headers: true) do |row|
      artist = Artist.find_by(name: row['name'])

      if artist
        artist.update(
          name: row['name'],
          spotify_name: row['spotify_name'],
          spotify_id: row['spotify_id']
          # 他の属性もここに追加
        )
        puts "Updated artist: #{artist.name}"
      else
        Artist.create(
          name: row['name'],
          spotify_name: row['spotify_name'],
          spotify_id: row['spotify_id']
          # 他の属性もここに追加
        )
        puts "Created artist: #{row['name']}"
      end
    end

    puts 'Artist data imported and updated successfully!'
  end
end
