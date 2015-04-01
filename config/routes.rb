QuizzApp::Application.routes.draw do
  resources :friendships

  resources :games do
    member do
      get 'start'
      put 'finish'
      get 'review'
    end

    collection do
      get "welcome"
      get "home"
      get 'paginate_available'
      get 'paginate_created'
      get 'paginate_passed'
    end
    resources :details, :controller => "game_details"
  end

  resources :quizzs, :shallow => true do
    resources :questions do
      resources :answers
    end
  end

  resources :quizzs do
    member do
      get 'complete'
    end
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :messages

  resources :accounts do
    member do
      post :notification_flag
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_for :users

  root :to => "games#home"
  get 'home'         => 'games#home'
  get 'statistics'   => 'games#welcome'
end
