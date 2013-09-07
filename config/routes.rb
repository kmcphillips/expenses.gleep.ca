ExpensesGleepCa::Application.routes.draw do

  root to: "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :categories, only: [:index, :new, :edit, :create, :update]

end
