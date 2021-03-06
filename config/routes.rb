Notesync::Application.routes.draw do

  post "user/create"

  get "user/new"

  post "user/logIn"

  get "user/logout"

  match "note/edit/:note" => "note#edit", :as => "note_edit"

  match "note/json/:note" => "note#json", :as => "note_json"

  match "note/view/:note" => "note#view", :as => "note_view"

  get "note/view"

  post "note/addParagraph"

  get "note/delete"

  post "lecture/create"

  get "lecture/new"

  get "lecture/list"

  match "lecture/view/:id" => "lecture#view", :as => "lecture_view"

  match "lecture/edit/:id" => "lecture#edit", :as => "lecture_edit"

  post "lecture/addUser/:id" => "lecture#addUser", :as => "lecture_addUser"

  match "lecture/addNote/:id" => "lecture#addNote", :as => "lecture_addNote"

  match "lecture/addDocument/:id" => "lecture#addDocument", :as => "lecture_addDocument"

  get "lecture/delete"

  get "paragraph/modify"

  get "paragraph/addLink"

  get "paragraph/delete"

  get "paragraph/between"

  get "paragraph/get"

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

  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
