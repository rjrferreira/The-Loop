App.ticket = App.cable.subscriptions.create {channel: "TicketChannel", user: document.querySelector('head').dataset.userId},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    for token in data
      if token["state"] == "SELECTED"
        if $("#owner").val() == token["owner"]
          $('.token[data-ticket-id='+token["code"]+']').removeClass("available selected_other unavailable");
          $('.token[data-ticket-id='+token["code"]+']').addClass("selected_owner");
        else
          $('.token[data-ticket-id='+token["code"]+']').removeClass("available selected_owner unavailable");
          $('.token[data-ticket-id='+token["code"]+']').addClass("selected_other");
          $('.token[data-ticket-id='+token["code"]+']').prop('disabled', true);
      else if token["state"] == "AVAILABLE"
        $('.token[data-ticket-id='+token["code"]+']').removeClass("selected_owner selected_other unavailable");
        $('.token[data-ticket-id='+token["code"]+']').addClass("available");
        $('.token[data-ticket-id='+token["code"]+']').prop('disabled', false);
      else if token["state"] == "UNAVAILABLE"
        $('.token[data-ticket-id='+token["code"]+']').removeClass("selected_owner selected_other available");
        $('.token[data-ticket-id='+token["code"]+']').addClass("unavailable");
        $('.token[data-ticket-id='+token["code"]+']').prop('disabled', true);
    # Called when there's incoming data on the websocket for this channel

  update: (code,owner) ->
    @perform 'update', code: code, owner: owner
    # call method update in ticket_channel.rb

  reserve: (owner, data_tickets_ids) ->
    @perform 'reserve', owner: owner, data_tickets_ids: data_tickets_ids
    # call method reserve in ticket_channel.rb

$ ->
  $(document).on 'click', '.token', (event) ->
    App.ticket.update($(this).attr("data-ticket-id"), $("#owner").val())

$ ->
  $(document).on 'click', '#reserve-all', (event) ->
    data_tickets_ids = [];
    $(".selected_owner").each (index, element) =>
       data_tickets_ids.push($(element).attr("data-ticket-id"));
    App.ticket.reserve($("#owner").val(),data_tickets_ids)

