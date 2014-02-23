Blog::Application.routes.draw do

  resources :reward_orders

  resources :products do
    collection do
      get :rewards
      get :wages
    end
  end

  resources :taggings

  resources :tags

  resources :fees

  # Saved places: lists, beens, etc
  resources :beens
  resources :wants
  resources :listeds
  resources :lists do
    collection do
      get 'management'
    end
  end

  # User contributions
  resources :photos

  resources :reviews

  resources :ratings

  # Tribes
  resources :vibes
  resources :tribal_memberships
  resources :tribes

  # Place guides
  resources :cities do
    get :browse, on: :member
  end
  resources :destinations do
    get :browse, on: :member
  end
  resources :states do
    collection do
      get 'browse_destinations'
    end
  end

  #Campsites
  resources :campsites do
    get :activities, on: :member
    collection do
      get 'search'
      get 'contrib'
    end
  end
  resources :activities
  resources :activity_types

  # Pages
  resources :pages
  # Devise & users
  devise_for :users, :controllers => { omniauth_callbacks:"users/omniauth_callbacks", registrations:"users/registrations" }
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'
  root to: 'pages#home', as: 'home'
  get :terms, to:'pages#terms', as: 'terms'
  get :privacy, to:'pages#privacy', as: 'privacy'
  get :takedown, to:'pages#takedown', as: 'takedown'

  # Devise sign_out needs a special path because OmniAuth is now included:
  #devise_scope :user do
     #get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  #end

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
