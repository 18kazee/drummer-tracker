require 'discogs-wrapper' # Discogs APIのラッパーライブラリを適切にインポート

namespace :import do
  desc "Import image URLs from Discogs"
  task image_urls: :environment do
    Drummer.all.each_slice(25) do |batch|
      batch.each do |drummer|
        auth_wrapper = Discogs::Wrapper.new("My awesome web app", user_token: ENV["DISCOGS_USER_TOKEN"])
        if drummer.discogs_id
          artist = auth_wrapper.get_artist(drummer.discogs_id) # drummer.discogs_id は文字列のまま渡す
          image_urls = []
          if artist&.images
            artist.images.each do |image|
              image_urls << image.uri
            end
          else
            puts "No images for #{drummer.name}"
          end
          drummer.update(image_urls:)
          puts "Updated #{drummer.name} with #{image_urls.count} image urls"
        else
          puts "No discogs_id for #{drummer.name}"
        end
      end
      sleep(60)
    end
  end
end
