Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('/general/home')

  namespace :general do
    resources :home
    resources :congresspeople, :only => [:index, :show]
    resources :upload_csv
    post '/import/', to: 'upload_csv#import', as: 'import'
    get '/congresspeople_ranking/', to: 'congresspeople#ranking', as: 'ranking'
  end
end
