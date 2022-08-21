Rails.application.routes.draw do
  root to: "questions#index"

  resources :questions do
    member do
      put "toggle_visibility"
    end
  end

  resources :users, only: %i[new create edit update destroy]
  resource :session, only: %i[new create destroy]
end
