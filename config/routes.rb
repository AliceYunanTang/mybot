Rails.application.routes.draw do
  resources :pictures
  root to: 'session#new'

  resources :users

  get    '/login' => 'session#new'
  post   '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/dragdrop' => 'pictures#dragdrop'
  post '/fileupload' => 'pictures#upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
