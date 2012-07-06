SwagFm::Application.routes.draw do

  resources :players, only: %w[create]

  root to: 'users#index'
end
