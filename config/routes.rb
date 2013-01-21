Amongster::Application.routes.draw do
  resources :photos, only: [:index] do
    get :geronimo, on: :collection
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'photos#index'
end
