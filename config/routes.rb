Rails.application.routes.draw do
  get '/mockups/today' => 'mockups#today'
  get '/mockups/tomorrow' => 'mockups#tomorrow'
  get '/mockups/reflect' => 'mockups#reflect'
  get '/mockups/nice_job' => 'mockups#nice_job'
  get '/mockups/dashboard' => 'mockups#dashboard'

  get '/dashboard' => 'dashboard#show', as: :dashboard
  get '/today' => 'today#show', as: :today
  get '/today/new' => 'today#new', as: :new_today
  post '/today' => 'today#create'
end
