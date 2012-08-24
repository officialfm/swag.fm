SwagFm::Application.routes.draw do

  resources :oauth_clients
  match '/oauth/test_request',  :to => 'oauth#test_request',  :as => :test_request
  match '/oauth/token',         :to => 'oauth#token',         :as => :token
  match '/oauth/access_token',  :to => 'oauth#access_token',  :as => :access_token
  match '/oauth/request_token', :to => 'oauth#request_token', :as => :request_token
  match '/oauth/authorize',     :to => 'oauth#authorize',     :as => :authorize
  match '/oauth',               :to => 'oauth#index',         :as => :oauth

  resource :session, controller: 'session'
  resources :users
  resources :tracks, only: %w[index create destroy]

  resources :extensions, only: [] do
    get :chrome, on: :collection
  end

  root to: 'users#index'
end
