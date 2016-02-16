Rails.application.routes.draw do
  get '/locations' => 'locations#index'

  get '/locations/new' => 'locations#new'
  post '/locations' => 'locations#create'

  get '/locations/:id' => 'locations#show'

end
