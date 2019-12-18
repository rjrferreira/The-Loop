class TicketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ticket_channel"
  end

  def unsubscribed
    # If i had authentication i knew the user name
    # use Rails.cache.delete 
  end
  
  def update data
    ticket = Rails.cache.read(data["code"])
    if ticket.nil?
      ticket = Ticket.new(code: data["code"], owner: data["owner"], state: "SELECTED")
    else
      ticket.state = "AVAILABLE"
      ticket.owner = nil
    end
    Rails.cache.write(data["code"], ticket)
    ActionCable.server.broadcast "ticket_channel", [{code: data["code"], owner: data["owner"], state: ticket.state}]
  end
  
  def reserve data
    tickets = []
    data["data_tickets_ids"].each do |ticket_code|
      ticket = Rails.cache.read(ticket_code)
      ticket.state = "UNAVAILABLE"
      ticket.owner = data["owner"]
      Rails.cache.write(ticket_code, ticket)
      tickets << {code: ticket_code, owner: data["owner"], state: "UNAVAILABLE"}
    end
    ActionCable.server.broadcast "ticket_channel", tickets
    
  end
  
end

