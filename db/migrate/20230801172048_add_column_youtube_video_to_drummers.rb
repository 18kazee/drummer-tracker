class AddColumnYoutubeVideoToDrummers < ActiveRecord::Migration[7.0]
  def change
    add_column :drummers, :youtube_videos, :string, array: true, default: []
  end
end
