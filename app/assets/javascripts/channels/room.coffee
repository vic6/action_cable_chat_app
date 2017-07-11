App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.content.blank?
      $('.chat').append '<li class="right clearfix">' + '<span class="chat-img pull-right">
       <img src="https://blogs-images.forbes.com/markhughes/files/2016/01/Terminator-2-1200x873.jpg?width=960" alt="User Avatar width="10" height="40"" class="img-circle"/>
     </span>' + '<div class="chat-body clearfix">
       <div class="header">' + '<strong class="pull-right primary-font">' + 'Robotrainer' + '</strong>
       <small class="text-muted">
         <span><br></span></small></div>' + '<p class="pull-right primary-font">' + data.bot + '</p>' + '</div>' + '</li>'
      scroll_bottom()

$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()

submit_message = () ->
  $('#btn-input').on 'keydown', (event) ->
    if event.keyCode is 13
      $('input').click()
      $('.chat').append '<li class="left clearfix">' + '<span class="chat-img pull-left">
       <img src="https://blogs-images.forbes.com/markhughes/files/2016/01/Terminator-2-1200x873.jpg?width=960" alt="User Avatar width="10" height="40"" class="img-circle"/>
     </span>' + '<div class="chat-body clearfix">
       <div class="header">' + '<strong class="pull-left primary-font">' + 'Victor' + '</strong>
       <small class="text-muted">
         <span><br></span></small></div>' + '<p class="pull-left primary-font">' + event.target.value + '</p>' + '</div>' + '</li>'
      event.target.value = ''
      event.preventDefault()
      scroll_bottom()

scroll_bottom = () ->
  $('.panel-body').scrollTop($('.panel-body')[0].scrollHeight)

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms
