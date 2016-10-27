Rails.application.routes.draw do
  resources :works
  #resources :telephones
  resources :contacts do |c|
    resources :telephones
  end
  #get '/telephones/:contact_id/new', to: 'telephones#new'  , as: 'tele'
  get '/contacts/rapport/:year', to: 'contacts#rapport' # url qui pointe vers une fonction dans le controller de contact
  get '/contacts/newWork/:contact',to: 'contacts#newWork', as: 'newWork'


  root 'contacts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
