class Ticket < ApplicationRecord

  def self.get_all_tickets
    tickets = Ticket.all.to_a.collect! do |ticket|
      ticket_cache = Rails.cache.read(ticket.code)
      ticket_cache ? ticket_cache : ticket
    end

    tickets
  end

  def self.get_all_subscribed_tickets
    keys = Rails.cache.instance_variable_get(:@data).keys
    tickets = Rails.cache.instance_variable_get(:@data).values

    keys = Rails.cache.keys
    byebug
    #cache_keys = cache_identifiers.keys


    tickets.collect! do |ticket|
      {code: ticket.value.code, owner: ticket.value.owner, state: ticket.value.state}
    end

    tickets

  end
end
