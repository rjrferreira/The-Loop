class TicketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ticket_channel"
  end

  def unsubscribed
  end
  
  def update data
    ticket = $redis.get(data["code"])
    
    if ticket.nil?
      $redis.set(data["code"], "#{data["owner"]}:SELECTED")
    else
      data_ticket = ticket.split(":")
      if data_ticket[1] == "AVAILABLE"
        $redis.set(data["code"], "#{data["owner"]}:SELECTED")
      else
        $redis.set(data["code"], ":AVAILABLE")
      end
    end
    
    ticket = $redis.get(data["code"]).split(":")
    
    ActionCable.server.broadcast "ticket_channel", [{code: data["code"], owner: ticket[0], state: ticket[1]}]
    
  end
  
  def reserve data
    tickets = []
    data["data_tickets_ids"].each do |ticket_code|
      $redis.set(ticket_code, "#{data["owner"]}:UNAVAILABLE")
      tickets << {code: ticket_code, owner: data["owner"], state: "UNAVAILABLE"}
    end
    ActionCable.server.broadcast "ticket_channel", tickets
  end
  
  def clear_cache 
    $redis.flushall
  end
  
end


