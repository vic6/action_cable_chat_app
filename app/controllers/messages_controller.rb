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
      response = ChatbotExtension.instance.client.text_request(message.content)
      response = response[:result][:fulfillment][:speech]
      delay = response.length * 0.01
      sleep(delay)
      # ActionCable.server.broadcast('room_channel',
      #                              content: message.content,
      #                              username: message.user.username,
      #                              bot: response)
      # sleep(2)
      #
      # ActionCable.server.broadcast('room_channel',
      #                              content: message.content,
      #                              username: message.user.username,
      #                              bot: response)
      ActionCable.server.broadcast('room_channel',
                                   content: render_response(response),
                                   bot: response
                                   )
      #
      # #
      # ActionCable.server.broadcast('room_channel',
      #                              bot: response)
      p '$' * 4000
      p response
      p '$' * 4000
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

  def render_message(message)
    p '*' * 500
    p message
    p '*' * 500

    render partial: 'message', locals: { message: message }
  end

  def render_response(message)
    p '*' * 500
    p message
    p '*' * 500
    render partial: 'message'
  end
end
