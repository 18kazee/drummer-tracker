# lib/tasks/update_drummer_genres.rake

namespace :import do
  desc 'Update existing drummer_genres data from CSV'
  task update_drummer_genres: :environment do
    file_path = 'db/csv/drummer_genres.csv' # ファイルパスを実際のパスに変更する

    CSV.foreach(file_path, headers: true) do |row|
      drummer_name = row['drummer']
      genres_names = row['genre']

      next if genres_names.nil?

      drummer = Drummer.find_by(name: drummer_name)

      if drummer
        genres_names.split(',').each do |genre_name|
          genre = Genre.find_or_create_by(name: genre_name.strip)

          drummer_genre = DrummerGenre.find_or_initialize_by(drummer:, genre:)
          if !drummer_genre.persisted?
            drummer_genre.save
            puts "#{drummer_name} - #{genre_name} updated!"
          else
            puts "#{drummer_name} - #{genre_name} already exists, skipping..."
          end
        end
      else
        puts "#{drummer_name} not found, skipping..."
      end
    end

    puts 'Drummer-Genre update task completed!'
  end
end
