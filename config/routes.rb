Rails.application.routes.draw do
    root to: 'colleges#index'
    resources :colleges, only: [:index]
end
