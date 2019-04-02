Rails.application.routes.draw do
  root 'palettes#index'

  post 'palettes/add_colour'

  resources :palettes
  resources :colours
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
