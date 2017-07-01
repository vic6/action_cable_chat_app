class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :get_messages
  include ChatbotHelper

  def index
  end

  # def initialize
  #   p 'ahhhh' * 500
  #   client = ApiAiRuby::Client.new(client_access_token: '90d1d538efc14e09b5aa4fac40238ad4')
  # end

  def create
    message = current_user.messages.build(message_params)
    if message.save
      p '*' * 50
      p message
      p '*' * 50
      ActionCable.server.broadcast('room_channel',
                                   content: message.content,
                                   username: message.user.username)
      send_message(message.content)
    else
      render 'index'
    end
  end

  def send_message(message)
    client = ApiAiRuby::Client.new(client_access_token: '90d1d538efc14e09b5aa4fac40238ad4')
    response = client.text_request(message)
    p '*' * 50
    p message
    p response[:result][:fulfillment][:speech]
    p '*' * 50
  end

  private

  def get_messages
    @messages = Message.for_display
    @message  = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
