class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :get_messages
  # include ChatbotHelper

  def index
  end

  # def send_message(message)
  #   response = @client.text_request(message)
  #   p '*' * 50
  #   p message
  #   p response[:result][:contexts]
  #   p '*' * 50
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

      response = ChatbotExtension.instance.client.text_request(message.content)
      p response[:result][:contexts]
      p response
    else
      render 'index'
    end
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
