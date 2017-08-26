Rails.application.routes.draw do

  resources :achievements

  get 'admin', to: 'admin#index'

  controller :sessions do
    get  'login', to: :new
    post 'login', to: :create
    delete 'logout', to: :destroy
  end

  get 'statistics/index', to: 'statistics#index'

  get 'statistics/teams', to: 'statistics#teams'

  get 'statistics/teams/:id', to: 'statistics#show_team'

  get 'statistics/players', to: 'statistics#players'

  get 'statistics/players/:id', to: 'statistics#show_player'
  
  get 'scoreboard', to: 'statistics#score_board'
  
  get 'scoreboard/:id', to: 'statistics#player_score_board'

  resources :rounds

  resources :matches do
      put 'create_event'
  end

  resources :teams

  resources :players do
    post 'achievement_check'
  end
  
  post 'achievement_check_all', to: 'statistics#achievement_check_all'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'statistics#index', as: 'statistics'

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
