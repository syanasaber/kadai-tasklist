Rails.application.routes.draw do
    root to: 'message#index'
    
    resources :tasks
end
