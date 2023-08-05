namespace :update do
  desc "Update youtube videos for drummers"
  task update_youtube_videos: :environment do
    empty_drummers = Drummer.where(youtube_videos: [])
    count = 0
    empty_drummers.each do |drummer|
      drummer.search_youtube_videos
      count += 1
      puts "Updated #{drummer.name}'s youtube videos"
      puts "Drummers updated: #{count}"
    end
  end
end
