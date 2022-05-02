class TicketsController < ApplicationController
  def show
    @tickets = Ticket.get_all_tickets
    @user = "guest_#{Time.now.to_i}"
  end
end
