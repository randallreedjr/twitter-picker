Rails.application.routes.draw do
  
  # Static pages
  root 'pages#home'

  # Omniauth
  get '/login' => 'sessions#new'
  get '/auth/twitter/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Sort campaigns by status
  get '/campaigns/ongoing' => 'campaigns#ongoing'
  get '/campaigns/completed' => 'campaigns#completed'
  get '/campaigns/all' => 'campaigns#all'
  #get '/campaigns/:id/tweet' => 'campaigns#tweet', as: :tweet_campaign

  resources :campaigns do
    resources :prizes, :only => [:create, :new, :edit, :update, :destroy] do
      resources :winners, :only => [:create, :destroy]
    end
    resources :tweets, :only => :index
  end
  resources :analytics, :only => :index
  #resources :users  

  
  get '/campaigns/:id/refresh' => 'campaigns#refresh', as: :refresh_tweets
  get '/campaigns/:id/all_winners' => 'winners#show_all_winners', as: :campaign_show_all_winners
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
