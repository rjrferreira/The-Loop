module TicketsHelper
  
  def self.ticket tickets, code
    tickets.select{|t| t.code == code}.first
  end
  
  def self.disabled ticket_code, user
    ticket = $redis.get(ticket_code)
    return "" if ticket.nil?
    data_ticket = ticket.split(":")
    (data_ticket[1] == "UNAVAILABLE" || (data_ticket[1] == "SELECTED" && data_ticket[0] != user)) ? "disabled" : ""
  end
  
  def self.state ticket_code, user
    ticket = $redis.get(ticket_code)
    return "available" if ticket.nil?
    
    data_ticket = ticket.split(":")
    unless data_ticket[0].blank?
      if data_ticket[1] == "SELECTED"
        if data_ticket[0] == user
          "selected_owner"
        else
          "selected_other"
        end
      else
        "unavailable"
      end
    else
      "available"
    end
  end
end
