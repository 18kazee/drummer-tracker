require 'csv'

namespace :import do
  desc 'Import drummer_artists data from CSV'
  task drummer_artists: :environment do
    file_path = 'db/csv/drummer_artists.csv' # ファイルパスを実際のパスに変更する

    CSV.foreach(file_path, headers: true) do |row|
      drummer_name = row['drummer_name']
      artist_names = row['artist_name']

      next if artist_names.nil? # artist_namesがnilの場合、次の行に進む

      drummer = Drummer.find_or_create_by(name: drummer_name)

      artist_names.split(',').each do |artist_name|
        artist = Artist.find_or_create_by(name: artist_name.strip)

        drummer_artist = DrummerArtist.find_or_initialize_by(drummer:, artist:)
        if !drummer_artist.persisted?
          drummer_artist.save
          puts "#{drummer_name} - #{artist_name} is updated!"
        else
          puts "#{drummer_name} - #{artist_name} is created!"
        end
      end
    end

    puts 'Drummer-Artist data imported successfully!'
  end
end
