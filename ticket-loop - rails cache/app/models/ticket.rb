class Ticket < ApplicationRecord

  def self.get_all_tickets
    tickets = Ticket.all.to_a

    tickets.collect! do |ticket|
      ticket_cache = Rails.cache.read(ticket.code)
      ticket_cache ? ticket_cache : ticket
    end

    tickets
  end
end
