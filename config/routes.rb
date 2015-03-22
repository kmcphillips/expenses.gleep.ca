ExpensesGleepCa::Application.routes.draw do

  root to: "home#index"

  get "users/auth/token/:token" => "users/token#token", as: "user_token"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :entries

  resources :categories, only: [:index, :new, :edit, :create, :update]
  resources :authorized_emails, only: [:index, :create, :destroy]
  resources :login_tokens, only: [:index, :create, :destroy]
  resources :households, only: [:show, :edit, :update]
  resources :entry_schedules
  resources :data, only: [:index] do
    collection do
      get :monthly_expense_income
      get :expense_breakdown
      get :yearly_breakdown
      get :yearly_totals
      get :car
    end
  end

end
