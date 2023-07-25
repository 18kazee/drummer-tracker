# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

csv_path = Rails.root.join("db/csv/drummers.csv")

CSV.foreach(csv_path, headers: true) do |row|
  Rails.logger.debug "Name: #{row['name']}, Country: #{row['country']}, Profile: #{row['profile']}"
  Drummer.create!(name: row['name'], country: row['country'].to_i, profile: row['profile'])
end