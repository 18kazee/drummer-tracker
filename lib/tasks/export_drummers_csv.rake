# lib/tasks/export_drummers_csv.rake

namespace :export do
  desc "Export drummers' data to CSV"
  task drummers_csv: :environment do
    require 'csv'

    drummers = Drummer.all # これは適切なモデル名に置き換えてください

    CSV.open("drummers.csv", "w") do |csv|
      csv << ["ID", "Name", "Discogs ID"] # CSVヘッダー

      drummers.each do |drummer|
        csv << [drummer.id, drummer.name, drummer.discogs_id]
      end
    end

    puts "Drummers' data exported to drummers.csv"
  end
end
