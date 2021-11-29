Rails.application.routes.draw do
  root 'auditions#new'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/manager', to: 'managers#audition_listing_portal', as: 'audition_listing_portal'
    post '/manager', to: 'managers#set_manager'
    get '/manager/:id', to: 'managers#show', as: 'audition'
    get '/manager/email/:id', to: 'managers#accept_mail', as: 'audition_accept_mail'
    post '/manager/email/:id', to: 'managers#send_mail', as: 'audition_send_mail'
  end
  get 'artist_profile/profile', to: 'artist_profiles#profile', as: 'profile_artist_profile'
  #get 'artist_profile/music', to: 'artist_profiles#music', as: 'music_artist_profile'
  post 'artist_profile/transacton', to: 'artist_profiles#transaction', as: 'transaction_artist_profile'
  get 'artist_profile/upgrade/:id', to: 'artist_profiles#upgrade', as: 'upgrade_artist_profile'
  resources :auditions
  resources :artist_profiles do
    resources :albums do
      resources :tracks do
        post '/submit', to: 'tracks#submit'
      end
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
