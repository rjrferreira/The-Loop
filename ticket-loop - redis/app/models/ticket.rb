class Ticket < ApplicationRecord
  after_update :update_tickets
  
  def update_tickets
    ActionCable.server.broadcast "ticket_channel", code: self.code, owner: self.owner, state: self.state
  end
end
