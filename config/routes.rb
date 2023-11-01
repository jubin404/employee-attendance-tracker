Rails.application.routes.draw do
  devise_for :admins, class_name: 'Admin::Admin'
  devise_for :employees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :employee
    resources :attendance
  end
end
