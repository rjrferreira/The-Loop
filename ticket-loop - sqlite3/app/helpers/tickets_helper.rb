module TicketsHelper
  
  def self.ticket tickets, code
    tickets.select{|t| t.code == code}.first
  end
  
  def self.disabled ticket, user
    (ticket.state == "UNAVAILABLE" || (ticket.state == "SELECTED" && ticket.owner != user)) ? "disabled" : ""
  end
  
  def self.state ticket, user
    unless ticket.owner.blank?
      if ticket.state == "SELECTED"
        if ticket.owner == user
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
