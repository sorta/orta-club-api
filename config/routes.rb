Rails.application.routes.draw do
  resources :donnings
  resources :gay_apparels
  resources :locations
  resources :members
  resources :users do
    collection do
      post 'login'
    end
  end
  resources :years
end
