SwagFm::Application.routes.draw do

  resources :users
  resources :tracks, only: %w[index create destroy]

  resources :extensions, only: [] do
    get :chrome, on: :collection
  end

  root to: 'users#index'
end
