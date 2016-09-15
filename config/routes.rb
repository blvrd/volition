Rails.application.routes.draw do
  get '/mockups/today' => 'mockups#today'
  get '/mockups/tomorrow' => 'mockups#tomorrow'
end
