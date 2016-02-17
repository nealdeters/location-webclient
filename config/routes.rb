Rails.application.routes.draw do
  get '/' => 'locations#index'
  get '/locations' => 'locations#index'

  get '/locations/new' => 'locations#new'
  post '/locations' => 'locations#create'

  get '/locations/:id' => 'locations#show'

  get '/locations/:id/edit' => 'locations#edit'
  patch '/locations/:id' => 'locations#update'

  delete '/locations/:id' => 'locations#destroy'

end
