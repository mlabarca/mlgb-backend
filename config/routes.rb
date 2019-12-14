Rails.application.routes.draw do
  # Using non resourceful routes since we won't store the favorite id's on the front
  post   'favorites/create'
  delete 'favorites/delete'

  get 'jobs/search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
