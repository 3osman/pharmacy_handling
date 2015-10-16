Rails.application.routes.draw do
  resources :templates
  get 'med_tables/view'

  get 'paper/first_step'

  get 'paper/generate_pdf'
  post 'paper/add_to_medicines', as: :add_m 
  get 'paper/add_empty'

  post 'paper/delete_entry'
  post 'paper/download_pdf'
  get 'paper/editmed'
  get 'med_tables/show_history'

  get 'med_tables/view', as: :view_history
  post 'med_tables/delete'
  get 'med_tables/delete_all'

  resources :patients
  get 'static_pages/home'

  resources :medicines

  devise_for :users do
    match 'users/sign_out' => 'devise/sessions#destroy',
    :controllers => { :sessions => "users/sessions" }
  end
  resources :users_admin, :controller => 'users'
  get 'users_admin/edit'

  get '/prescription', to: 'paper#first_step' , as: :prescription
  get '/', to: 'static_pages#home', as: :root
  get '/choose-medicine', to: 'paper#generate_pdf' , as: :choose

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
