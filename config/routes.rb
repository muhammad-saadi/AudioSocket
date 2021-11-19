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

  resources :auditions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
