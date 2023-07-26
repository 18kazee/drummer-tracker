require 'csv'

namespace :import do
  desc 'Import drummer_genres data from CSV'
  task drummer_genress: :environment do
    file_path = 'db/csv/drummer_genres.csv' # ファイルパスを実際のパスに変更する

    CSV.foreach(file_path, headers: true) do |row|
      drummer_name = row['drummer']
      genres_names = row['genre']

      next if genres_names.nil? # artist_namesがnilの場合、次の行に進む

      genres_names.split(',').each do |genre_name|
        drummer = Drummer.find_or_create_by(name: drummer_name)
        genre = Genre.find_or_create_by(name: genre_name.strip)

        DrummerGenre.find_or_create_by(drummer: drummer, genre: genre)
      end
    end

    puts 'Drummer-Genre data imported successfully!'
  end
end
