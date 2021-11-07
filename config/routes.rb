Rails.application.routes.draw do
  resources :donnings
  resources :years
  resources :members
  resources :users do
    collection do
      post 'login'
    end
  end
end
