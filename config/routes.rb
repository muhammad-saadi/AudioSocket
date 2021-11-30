Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    namespace :manager do
      resources :auditions, only: [:index, :show] do
        member do
          post :set_manager
          get :accept_mail
          post :send_mail
        end
      end
    end
  end

  resources :auditions
  resource :artist_profile do
    get :profile
    get :upgrade
    post :pay
  end
    resources :albums do
      resources :tracks do
        post :submit
      end
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'auditions#new'
end
