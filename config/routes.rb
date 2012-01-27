Terminplaner::Application.routes.draw do
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :friendships

  resources :groups

  resources :user_sessions



  resources :users

  #resource :user, :as => 'account'  # a convenience route
  resource :user, :as => :friend

  match 'signup' => 'users#new', :as => :signup

  get "home/index"

  resources :appointments

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  #TODO  testen und so umschreiben das man das lazout aendert,gendwas mit dem session im application_controller def setLayout stimmt nicht

  match 'appointments#index' => "application", :action=>"set_layout", :mobile=>"1"
  match 'appointments#index' => "application", :action=>"set_layout", :mobile=>"0"


  # User Activation
  match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account
  match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation


  resources :password_resets

  #put 'password_reset/:password_reset_code' => 'users#password_reset', :as => :password_reset, :via => :put
  #get 'password_reset/:password_reset_code' => 'users#password_reset', :as => :password_reset, :via => :get


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
  # root :to => 'welcome#index'

  #            rm public/index.html # in der console
  root :to => 'appointments#index'
  #root :to => 'user_sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'




end
