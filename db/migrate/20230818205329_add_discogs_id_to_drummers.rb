class AddDiscogsIdToDrummers < ActiveRecord::Migration[7.0]
  def change
    add_column :drummers, :discogs_id, :string
  end
end
