SwagFm::Application.routes.draw do

  resources :players, only: %w[index create destroy]

  resources :extensions, only: [] do
    get :chrome, on: :collection
  end

  root to: 'users#index'
end
