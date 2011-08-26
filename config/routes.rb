Microbump::Application.routes.draw do

  get 'admin' => "admin/dashboard#index"
  namespace :admin do
    get "dashboard" => "dashboard#index"

    post "new_session" => "sessions#create"
    get "login" => "sessions#new"
    get "logout" => "sessions#destroy"

    resources :posts do
      member do
        post "unpublish"
        post "publish"
      end
    end
  end

  resources :posts, :only => [:show, :index]

  root :to => 'site#index'
end
