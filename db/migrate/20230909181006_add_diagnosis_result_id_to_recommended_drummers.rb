class AddDiagnosisResultIdToRecommendedDrummers < ActiveRecord::Migration[7.0]
  def change
     add_column :recommended_drummers, :diagnosis_result_id, :integer
     add_foreign_key :recommended_drummers, :diagnosis_results
  end
end
