Rails.application.routes.draw do
  # root 'messages#index'
  resources :users
  resources :messages
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  post   '/test',    to: 'chatbot#test'
  constraints subdomain: "hooks" do
  post '/:integration_name' => 'chatbot#test', as: :receive_webhooks
  end
  delete '/logout',  to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end
