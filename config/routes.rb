Rails.application.routes.draw do
  resources :frames

  resources :games do
    put 'start', to: 'games#start', as: :start_game
    resources :frames
  end

  resources :code_uploads
  resources :players do
    resources :code_uploads
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
