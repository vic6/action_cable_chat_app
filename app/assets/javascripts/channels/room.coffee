App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.content.blank?
      $('.chat').append '<li class="left clearfix">' + '<div class="chat-body clearfix">
       <div class="header">
       <small class="text-muted">
         <span><br></span></small></div>' + '<p class="pull-right primary-font">' + '<div class="typing-indicator left clear">
  <span></span>
  <span></span>
  <span></span>
</div>'+ '</p>' + '</div>' + '</li>'
      $('.chat').append '<li class="left clearfix">' + '<div class="chat-body clearfix">
       <div class="header">
       <small class="text-muted">
         <span><br></span></small></div>' + '<p class="pull-right primary-font bubble-bot">' + data.bot + '</p>' + '</div>' + '</li>'
      scroll_bottom()

$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()

submit_message = () ->
  $('#btn-input').on 'keydown', (event) ->
    if event.keyCode is 13
      $('input').click()
      $('.chat').append '<li class="right clearfix">' + '<div class="chat-body clearfix">
       <div class="header">
       <small class="text-muted">
         <span><br></span></small></div>' + '<p id="current" class="pull-left primary-font bubble">' + event.target.value + '</p>' + '</div>' + '</li>' +


      event.target.value = ''
      event.preventDefault()
      scroll_bottom()

scroll_bottom = () ->
  $('.panel-body').scrollTop($('.panel-body')[0].scrollHeight)

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms
