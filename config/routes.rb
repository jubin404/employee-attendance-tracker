Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }, path: 'admin' 

  devise_for :employees, controllers: {
    sessions: 'employees/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :employee
    post 'employee/new', to: 'employee#create'
    resources :attendance
    post 'attendance/new', to: 'attendance#create'
  end

  get 'dashboard', to: 'employee/dashboard#index'
end
