Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  ActiveAdmin.routes(self)
  root 'pages#index'
  get 'paid' => 'pages#paid'
end
