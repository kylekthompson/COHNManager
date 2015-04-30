Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  ActiveAdmin.routes(self)
  root 'pages#index'
  get 'paid' => 'pages#paid'
  get 'unpaid' => 'pages#unpaid'
  get 'incorrectgym' => 'pages#incorrectgym'
  get 'setgympage' => 'pages#setgympage'
  get 'waiver' => 'pages#waiver'
  post 'setgym' => 'pages#setgym'
  get 'pay' => redirect("https://www.cohncrossfit.com/join-us/")
end
