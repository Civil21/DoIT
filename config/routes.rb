Rails.application.routes.draw do
  get '/:locale' => 'questions#index'
  
  root to: 'questions#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :categories, only:[:index,:show]

  resources :questions do 
  	member do 
  		get :chosen
  	end
  	resources :answers, only:[:create,:update,:destroy] 
    resources :qcomments, only:[:create,:update,:destroy]

  end

  resources :answers, only:[] do
    resources :anscomments, only:[:create,:update,:destroy]
  end

  scope "(:locale)", locale: /en|uk/ do
    resources :questions
    resources :users
    resources :answers
    resources :qcomments
    resources :anscomments
    resources :pages
  end

    get "uk", to: "application#locale_uk", as:"locale_uk" 
    get "en", to: "application#locale_en", as:"locale_en"
    
    get "answers/:id/positiv_vote", to: "answers#positiv_vote", as:"positiv_vote"
  	get "answers/:id/negativ_vote", to: "answers#negativ_vote", as:"negativ_vote"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
