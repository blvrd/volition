Rails.application.routes.draw do
  root 'marketing#home'

  get    '/mockups/today'             => 'mockups#today'
  get    '/mockups/tomorrow'          => 'mockups#tomorrow'
  get    '/mockups/reflect'           => 'mockups#reflect'
  get    '/mockups/nice_job'          => 'mockups#nice_job'
  get    '/mockups/dashboard'         => 'mockups#dashboard'
  get    '/mockups/settings'          => 'mockups#settings'

  get    '/nice_job'                  => 'pages#nice_job', as: :nice_job
  get    '/welcome'                   => 'pages#welcome', as: :welcome
  get    '/privacy'                   => 'marketing#privacy', as: :privacy
  get    '/running_costs'             => 'marketing#running_costs', as: :running_costs

  get    '/dashboard'                 => 'dashboard#show', as: :dashboard
  get    '/today'                     => 'today#show', as: :today
  get    '/today/new'                 => 'today#new', as: :new_today
  post   '/today'                     => 'today#create'
  get    '/tomorrow'                  => 'tomorrow#new', as: :tomorrow
  post   '/tomorrow'                  => 'tomorrow#create'
  get    '/reflect'                   => 'reflections#new', as: :reflect
  get    '/login'                     => 'sessions#new', as: :login
  post   '/login'                     => 'sessions#create'
  get    '/get_google_sign_in_iframe' => 'sessions#get_google_sign_in_iframe'
  delete '/logout'                    => 'sessions#destroy', as: :logout
  get    '/settings'                  => 'users#edit', as: :settings
  get    '/add_google_sign_in'        => 'users#add_google_sign_in', as: :add_google_sign_in

  resources :todos, only: [:update]
  resources :days, only: [:show]
  resources :reflections, only: [:create]
  resources :users do
    member do
      delete :cancel_subscription
    end
  end

  require 'sidekiq/web'
  mount Sidekiq::Web,        at: '/sidekiq'
  mount StripeEvent::Engine, at: '/stripe-events'
end
