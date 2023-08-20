class AddImageUrlsToDrummers < ActiveRecord::Migration[7.0]
  def change
    add_column :drummers, :image_urls, :string, array: true, default: []
  end
end
