Rails.application.routes.draw do
  namespace :staff do
    get    'login'   => 'sessions#new',    as: :login
    post   'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    root 'top#index'
  end

  namespace :admin do
    get    'login'   => 'sessions#new',    as: :login
    post   'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
