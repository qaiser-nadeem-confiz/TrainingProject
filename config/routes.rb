SocialMesh::Application.routes.draw do


  get "user/create"

  resources :posts

  get 'user_profiles/edit' => 'user_profiles#edit'
  get "home/index"
  #get "user_profiles/searchProfile" => 'user_profiles#search'
  get "friend_request/sendRequest/" , as:'sendRequest'
  get '/logout' =>'home#logout' , as: 'logout'
  get '/signup' =>'home#signUp',as: 'signup'
  post '/signup'=>'home#authorise'
  get '/login' =>'home#login' , as: 'login'
  post '/login' =>'home#handleLogin'

  get '/user_profiles/makeFriends/' ,as: 'makeFriend'
  get '/user_profiles/rejectFriendRequest/' => 'user_profiles#rejectFriendRequest' , as: 'rejectRequest'
  get '/user_profiles'=> 'user_profiles#index'
  get'/friend_request/showPending'
  get '/user_profiles/show'
  #get '/friend_request/:id' => 'friend_request#sendRequest'
  #get '/user_profiles/:id' =>'user_profiles#edit'

  resource :friend_request
  resources :accounts
  resources :friend_lists
  resources :user_profiles do
resources :comments
resources :notifications
end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'home#index'
  match '/:anything', :to => "home#routing_error", :constraints => { :anything => /.*/ }
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
