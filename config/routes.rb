Book::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user_registrations"}
 
  namespace 'user' do
    resources 'dashboard', :only => [:index]
    resource 'profile', :only => [:show, :destroy]
  end

  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/auth/facebook/logout' => 'authentications#facebook_logout', :as => :facebook_logout
    
  root :to => 'home#index'
end
