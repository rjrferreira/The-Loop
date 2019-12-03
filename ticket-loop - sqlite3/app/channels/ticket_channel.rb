class TicketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ticket_channel"
  end

  def unsubscribed
    # If i had authentication i knew the user name
    #    Ticket.where({owner: "guest_1575269869", state: "SELECTED"}).each do |t|
    #      t.state = "AVAILABLE"
    #      t.owner = nil
    #      t.save
    #    end
  end
  
  def update data
    t = Ticket.find_by({code: data["code"]})
    if t.owner.blank?
      t.state = "SELECTED"
      t.owner = data["owner"]
    else
      t.state = "AVAILABLE" if t.state == "SELECTED"
      t.owner = nil
    end
    t.save
  end
  
  def reserve data
    Ticket.where({owner: data["owner"], state: "SELECTED"}).each do |t|
      t.state = "UNAVAILABLE"
      t.save
    end
  end
  
end


