Curesource::Application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_scope :users do
    match '/users/:id',       to: "users#show",    via: 'get'
    match '/users/:id',       to: "users#show",    via: 'patch'
  end
  resources :users, only: [:show, :index]
  resources :departments do
    resources :courses
    resources :posts
    post :pin
    delete :deletepin
  end

  resources :courses do
    resources :posts 
  end

  resources :posts do
    resources :comments
    post :pin
    delete :delete_pin
  end

  resources :favorites, only: [:create, :destroy]


  root 'departments#index'
  match '/help',                        to: 'pages#help',               via: 'get'
  match '/about',                       to: 'pages#about',              via: 'get'
  match '/contact',                     to: 'pages#contact',            via: 'get'
  match '/link',                        to: 'pages#link',               via: 'get'
  match '/post/:post_id/comments/:id',  to: 'comments#delete',          via: 'delete'
  match '/departments#departments',     to: 'departments#index',        via: 'get'


  #match '/departments/:department_id',  to: 'posts#show',               via: 'post'
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
