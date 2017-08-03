Rails.application.routes.draw do

  root to: 'session#new'

  resources :users
  resources :pictures
  get    '/login' => 'session#new'
  post   '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/dragdrop' => 'pictures#dragdrop'
  post '/fileupload' => 'pictures#upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
