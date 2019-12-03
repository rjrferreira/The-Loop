App.ticket = App.cable.subscriptions.create "TicketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data["state"] == "SELECTED" 
      if $("#owner").val() == data["owner"]
        $('.token[data-ticket-id='+data["code"]+']').removeClass("available selected_other unavailable");
        $('.token[data-ticket-id='+data["code"]+']').addClass("selected_owner");
      else
        $('.token[data-ticket-id='+data["code"]+']').removeClass("available selected_owner unavailable");
        $('.token[data-ticket-id='+data["code"]+']').addClass("selected_other");
        $('.token[data-ticket-id='+data["code"]+']').prop('disabled', true);
    else if data["state"] == "AVAILABLE"
      $('.token[data-ticket-id='+data["code"]+']').removeClass("selected_owner selected_other unavailable");
      $('.token[data-ticket-id='+data["code"]+']').addClass("available");
      $('.token[data-ticket-id='+data["code"]+']').prop('disabled', false);
    else if data["state"] == "UNAVAILABLE"
      $('.token[data-ticket-id='+data["code"]+']').removeClass("selected_owner selected_other available");
      $('.token[data-ticket-id='+data["code"]+']').addClass("unavailable");
      $('.token[data-ticket-id='+data["code"]+']').prop('disabled', true);

    # Called when there's incoming data on the websocket for this channel

  update: (code,owner) ->
    @perform 'update', code: code, owner: owner
    # call method update in ticket_channel.rb
  
  reserve: (owner) ->
    @perform 'reserve', owner: owner
    # call method reserve in ticket_channel.rb

$ ->
  $(document).on 'click', '.token', (event) ->
    App.ticket.update($(this).attr("data-ticket-id"), $("#owner").val())

$ ->
  $(document).on 'click', '#reserve-all', (event) ->
    App.ticket.reserve($("#owner").val())

