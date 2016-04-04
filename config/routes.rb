Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'

  resources :users do
    member do
      get 'unvote_target'
    end
  end

  resources :impressions do
    member do
      get 'like'
      get 'unlike'
    end
  end

end
