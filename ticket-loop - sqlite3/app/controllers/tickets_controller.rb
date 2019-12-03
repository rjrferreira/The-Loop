class TicketsController < ApplicationController
  def show
    @tickets = Ticket.all
    @user = "guest_#{Time.now.to_i}"
  end
end
