Rails.application.routes.draw do
  root "tickets#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :tickets, only: %i[new create index show]

  namespace :admin do
    resources :tickets, only: %i[index destroy] do
      member do
        put :start
        put :resolve
      end

      resources :comments, only: %i[new create]
    end
  end
end
