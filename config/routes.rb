Rails.application.routes.draw do
  resources :donnings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :members
  resources :users do
    collection do
      post 'login'
    end
  end
end
