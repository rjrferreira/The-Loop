class TicketsController < ApplicationController
  def show
    @user = "guest_#{Time.now.to_i}"
  end
end
