Book::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user_registrations"}
 
  namespace 'user' do
    resources 'dashboard', :only => [:index]
    resource 'profile', :only => [:show, :destroy]
    resources :posts
  end
    
  root :to => 'home#index'
end
