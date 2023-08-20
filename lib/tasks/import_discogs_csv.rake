# lib/tasks/import_discogs_csv.rake

namespace :import do
  desc "Import Discogs data from CSV"
  task discogs_csv: :environment do
    require 'csv'

    csv_file = "db/csv/discogs.csv" # CSVファイル名

    CSV.foreach(csv_file, headers: true) do |row|
      drummer_id = row["ID"].to_i
      discogs_id = row["Discogs ID"]

      next if discogs_id.blank? # Discogs IDが空の場合はスキップ

      drummer = Drummer.find_by(id: drummer_id)
      next unless drummer

      drummer.update(discogs_id:)
      puts "Updated Discogs ID for #{drummer.name}"
    end
  end
end
