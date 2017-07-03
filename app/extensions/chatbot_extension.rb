require 'api-ai-ruby'
require 'singleton'

class ChatbotExtension
  include Singleton
  attr_reader :client

  def initialize
    @client = ApiAiRuby::Client.new(client_access_token: 'bfd4fd5b398a4f6693d83ca72fe518c6')
  end
end
