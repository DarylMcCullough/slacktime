Rails.application.routes.draw do

  resources :commands, only: [:create]

end
