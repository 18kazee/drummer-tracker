require 'csv'

namespace :import_artist do
  desc 'Import artists from CSV'
  task :artists => :environment do

    csv_file_path = 'db/csv/artists.csv'  # CSVファイルのパスを指定してください

    CSV.foreach(csv_file_path, headers: true) do |row|
      artist = Artist.find_or_create_by(name: row['name'], spotify_name: row['spotify_name'])
    end
    puts 'Artist data imported successfully!'
  end
end
