Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }, path: 'admin' 

  devise_for :employees, controllers: {
    sessions: 'employee/sessions'
  }

  root 'welcome#index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :employee
    post 'employee/new', to: 'employee#create'
    resources :attendance
    post 'attendance/new', to: 'attendance#create'
  end

  scope module: 'employee' do
    get 'dashboard', to: 'dashboard#index'
    resources :attendance
    resources :profile
  end
end
