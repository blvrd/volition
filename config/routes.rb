Rails.application.routes.draw do
  get '/mockups/today' => 'mockups#today'
  get '/mockups/tomorrow' => 'mockups#tomorrow'
  get '/mockups/reflect' => 'mockups#reflect'
  get '/mockups/nice_job' => 'mockups#nice_job'
  get '/mockups/dashboard' => 'mockups#dashboard'
end
