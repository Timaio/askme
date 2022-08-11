Rails.application.routes.draw do
  resources :questions do
    member do
      put 'hide'
    end
  end
end
