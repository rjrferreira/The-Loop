class TicketChannel < ApplicationCable::Channel
  def subscribed
    puts "new channel for #{params["user"]}"
    stream_from "ticket_channel"
  end

  def unsubscribed
    puts "user #{params["user"]} has left"
  end

  def update data
    ticket = Rails.cache.read(data["code"])
    if ticket.nil?
      ticket = Ticket.new(code: data["code"], owner: data["owner"], state: "SELECTED")
      Rails.cache.write(data["code"], ticket, expires_in: 10.minutes)
    else
      if ticket.owner == data["owner"] and ticket.state != "UNAVAILABLE"
        Rails.cache.delete(data["code"])
        ticket.state = "AVAILABLE"
        ticket.owner = nil
      end
    end

    tickets = Ticket.get_all_tickets
    ActionCable.server.broadcast "ticket_channel", tickets
  end

  def reserve data
    tickets = []
    data["data_tickets_ids"].each do |ticket_code|
      ticket = Rails.cache.read(ticket_code)
      if ticket && ticket.owner == data["owner"]
        ticket.state = "UNAVAILABLE"
        ticket.owner = data["owner"]
        Rails.cache.write(ticket_code, ticket)
      end
    end
    tickets = Ticket.get_all_tickets
    ActionCable.server.broadcast "ticket_channel", tickets

  end

end

