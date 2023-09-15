class RemoveSongs < ActiveRecord::Migration[7.0]
  def up
    drop_table :songs
  end

  def down
    create_table :songs do |t|
      t.string :name
      t.string :url
      t.references :drummer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
