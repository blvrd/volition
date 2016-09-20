Rails.application.routes.draw do
  root 'dashboard#show'

  get '/mockups/today' => 'mockups#today'
  get '/mockups/tomorrow' => 'mockups#tomorrow'
  get '/mockups/reflect' => 'mockups#reflect'
  get '/mockups/nice_job' => 'mockups#nice_job'
  get '/mockups/dashboard' => 'mockups#dashboard'

  get '/dashboard' => 'dashboard#show', as: :dashboard
  get '/today' => 'today#show', as: :today
  get '/today/new' => 'today#new', as: :new_today
  post '/today' => 'today#create'
  get '/reflect' => 'reflections#new', as: :reflect

  resources :todos, only: [:update]
  resources :reflections, only: [:create]
end
