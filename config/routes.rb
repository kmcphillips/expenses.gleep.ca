ExpensesGleepCa::Application.routes.draw do

  root to: "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :entries

  resources :categories, only: [:index, :new, :edit, :create, :update]
  resources :authorized_emails, only: [:index, :create, :destroy]
  resources :households, only: [:show, :edit, :update]
  resources :entry_schedules

end
