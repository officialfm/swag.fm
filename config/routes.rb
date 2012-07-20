SwagFm::Application.routes.draw do

  resources :players, only: %w[create] do
    get :bookmarks, on: :collection
  end

  resources :extensions, only: [] do
    get :chrome, on: :collection
  end

  root to: 'users#index'
end
