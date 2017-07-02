require 'api-ai-ruby'
require 'singleton'

class ChatbotExtension
  include Singleton

  def initialize
    @client = ApiAiRuby::Client.new(client_access_token: '90d1d538efc14e09b5aa4fac40238ad4')
  end

  def client
    return @client
  end
end
