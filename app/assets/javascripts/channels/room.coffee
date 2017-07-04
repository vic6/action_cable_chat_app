App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.content.blank?
      $('#messages-table').append '<div class="message">' +
        '<div class="message-user">' + data.username + ":" + '</div>' +
        '<div class="message-content">' + data.content + '</div>' + '</div>'

      $('#messages-table').append '<div class="message">' +
        '<div class="message-user">' + 'Robotrainer' + ":" + '</div>' +
        '<div class="message-content">' + data.bot + '</div>' + '</div>'
      scroll_bottom()

$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('input').click()
      event.target.value = ''
      event.preventDefault()

scroll_bottom = () ->
  $('#messages').scrollTop($('#messages')[0].scrollHeight)

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms
