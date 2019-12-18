Ticket.delete_all
(1..25).each do |row|
  (1..20).each do |column|
    Ticket.create({code: "#{row}_#{column}", state: "AVAILABLE"})
  end
end