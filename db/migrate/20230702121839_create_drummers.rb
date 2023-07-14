class CreateDrummers < ActiveRecord::Migration[7.0]
  def change
    create_table :drummers do |t|
      t.string :name, null: false
      t.integer :country, null: false
      t.text :profile

      t.timestamps
    end
  end
end
