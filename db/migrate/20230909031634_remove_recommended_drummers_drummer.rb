class RemoveRecommendedDrummersDrummer < ActiveRecord::Migration[7.0]
  def up
    drop_table :recommended_drummers_drummers
  end

  def down
    create_table :recommended_drummers_drummers do |t|
      t.bigint "recommended_drummer_id", null: false
      t.bigint "drummer_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["drummer_id"], name: "index_recommended_drummers_drummers_on_drummer_id"
      t.index ["recommended_drummer_id"], name: "index_recommended_drummers_drummers_on_recommended_drummer_id"
    end
  end
end
