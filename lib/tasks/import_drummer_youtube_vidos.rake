require 'csv'

namespace :import do
  desc 'Import drummer_youtube_videos data from CSV'
  task drummer_youtube_videos: :environment do
    file_path = 'db/csv/drummer_youtube_videos.csv' # ファイルパスを実際のパスに変更する

    CSV.foreach(file_path, headers: true) do |row|
      drummer_name = row['name']
      drummer_youtube_videos = row['youtube_videos']

      next if drummer_youtube_videos.nil?  youtubeがnilの場合、次の行に進む

      drummer = Drummer.find_or_create_by(name: drummer_name, youtube_videos: drummer_youtube_videos)
    end

    puts 'Drummer-youtube data imported successfully!'
  end
end
