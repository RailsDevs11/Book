Book::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "user_registrations"}
 
  namespace 'user' do
    resources 'dashboard', :only => [:index]
    resource 'profile', :only => [:show, :destroy]
    resources :book_details
  end

  namespace 'public' do
    resources :book_details do 
      member do
        post :buy_book
      end
    end
  end
  
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/auth/facebook/logout' => 'authentications#facebook_logout', :as => :facebook_logout
  
  resources :book_details
  match '/buy_book' => 'book_details#buy_book', :as => :buy_book

  root :to => 'home#index'

end
