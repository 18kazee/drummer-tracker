require 'csv'

namespace :import do
  desc 'Import drummer_youtube_videos data from CSV'
  task drummer_youtube_videos: :environment do
    file_path = 'db/csv/drummers_youtube_videos.csv' # ファイルパスを実際のパスに変更する

    CSV.foreach(file_path, headers: true) do |row|
      drummer_name = row['Name']
      drummer_youtube_videos = row['youtube_videos']

      next if drummer_youtube_videos.nil?

      drummer = Drummer.find_or_create_by(name: drummer_name)
      youtube_ids = drummer_youtube_videos.split(',').map(&:strip)
      drummer.youtube_videos = youtube_ids
      drummer.save
    end

    puts 'Drummer-youtube data imported successfully!'
  end
end
