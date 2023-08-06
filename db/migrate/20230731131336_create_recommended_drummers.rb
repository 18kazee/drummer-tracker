class CreateRecommendedDrummers < ActiveRecord::Migration[7.0]
  def change
    create_table :recommended_drummers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :drummer, null: false, foreign_key: true

      t.timestamps
    end
  end
end