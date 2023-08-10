require 'csv'

namespace :import_drummer do
  desc 'Import drummers from CSV'
  task drummers: :environment do
    csv_file_path = 'db/csv/drummers.csv'  # CSVファイルのパスを指定してください

    CSV.foreach(csv_file_path, headers: true) do |row|
      drummer = Drummer.find_by(name: row['name'])

      if drummer
        drummer.update(
          name: row['name'],
          country: row['country'].to_i,
          profile: row['profile']
          # 他の属性もここに追加
        )
        puts "Updated drummer: #{drummer.name}"
      else
        Drummer.create(
          name: row['name'],
          country: row['country'].to_i,
          profile: row['profile']
          # 他の属性もここに追加
        )
        puts "Created drummer: #{row['name']}"
      end
    end

    puts 'Drummer data imported and updated successfully!'
  end
end
