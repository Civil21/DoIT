Rails.application.routes.draw do
  get 'qcomments/_elem'
  get 'anscomments/_elem'
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

  end

    get "answers/:answer_id/anscomment", to: "anscomment#create", as:"answer_anscomment"
    patch "answers/:answer_id/anscomment/:id", to: "anscomment#update"
    delete "answers/:answer_id/anscomment/:id", to: "anscomment#destroy"

    get "questions/:question_id/qcomment", to: "qcomment#create", as:"question_qcomment"
    patch "questions/:question_id/qcomment/:id", to: "qcomment#update"
    delete "questions/:question_id/qcomment/:id", to: "qcomment#destroy"

  	
    get "answers/:id/positiv_vote", to: "answers#positiv_vote", as:"positiv_vote"
  	get "answers/:id/negativ_vote", to: "answers#negativ_vote", as:"negativ_vote"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
