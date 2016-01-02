Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users, only: [:edit, :show, :update] do
    resources :events 
  end

  get '/users/:id/dashboard' => 'dashboard#index', as: 'user_dashboard'

  resources :invitations, only: [:create, :update, :destroy]
  resources :search, only: [:index, :create]
  post "/api/v1/search" => "api#search"

  get '/events' => 'events#index_all'
  get '/events/past' => 'events#index_past'
  get '/performers' => 'users#index_performers'
  post '/reviews' => 'reviews#create'

  get '/users/:user_id/contents' => 'contents#edit', as: 'user_content'
  post '/users/:user_id/contents' => 'contents#update'
  delete '/users/:user_id/contents' => 'contents#destroy'

  post '/users/:id/email' => 'emails#create', as: 'user_email'

  get '/venues/:id' => 'venues#show', as: 'venue'
  get '/discover' => 'discover#index', as: 'discover'

  get '/settings' => 'settings#index', as: 'settings'
  post '/settings/language' => 'settings#change_language', as: 'settings_change_language'

  root to: 'sites#index'
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
