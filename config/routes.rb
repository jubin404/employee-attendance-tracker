Rails.application.routes.draw do
  devise_for :admins
  devise_for :employees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'admin/dashboard#index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :employee
    post 'employee/new', to: 'employee#create'
    resources :attendance
  end
end
