Rails.application.routes.draw do  
  root to: "questions#index"

  get "search", to: "search#index"
  
  resources :users, except: %i[index], param: :nickname
  resource :session, only: %i[new create destroy]
  resources :questions do
    member do
      put "toggle_visibility"
    end
  end
end
