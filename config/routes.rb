# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root 'exchanges#index'
  get '/convert_currency',       to: 'exchanges#convert_currency'
  get '/convert_cryptocurrency', to: 'exchanges#convert_cryptocurrency'
end
