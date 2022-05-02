# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ticket.delete_all
puts "run seeds"
(1..25).each do |row|
  (1..20).each do |column|
    Ticket.create({code: "#{row}_#{column}", state: "AVAILABLE"})
  end
end