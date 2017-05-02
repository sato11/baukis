Rails.application.routes.draw do
  config = Rails.application.config.baukis

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      get      'login' => 'sessions#new', as: :login
      resource :session, only: %i(create destroy)
      resource :account, except: %i(new create destroy)
      resource :password, only: %i(show edit update)
      resources :customers
      root 'top#index'
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      get       'login' => 'sessions#new', as: :login
      resource  :session, only: %i(create destroy)
      resources :staff_members, path: 'staff' do
        resources :staff_events, only: :index
      end
      resources :staff_events, only: :index
      root 'top#index'
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
