Rails.application.routes.draw do
  root to: "questions#index"

  resources :questions do
    member do
      put "toggle_visibility"
    end
  end

  resources :users, except: %i[index], param: :nickname
  resource :session, only: %i[new create destroy]
end
