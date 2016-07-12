Rails.application.routes.draw do

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


  resources :users, only: [:new, :create]
  # delete "/sessions" => "sessions#destroy"
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  # "/api/v1/questions" -> index
  # get "/api/v1/questions" => "api/v1/questions#index"

  # this will prepend all the urls for the questions with /api/v1 but it
  # will still point to the questions_controller.rb
  # scope :api do
  #   scope :v1 do
  #     resources :questions, only: [:index, :show]
  #   end
  # end

  # this will prepend all the urls for the questions with /api/v1 and it
  # will point to the api/v1/questions_controller.rb
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :questions, only: [:index, :show] do
        resources :answers, only: [:create]
      end
    end
  end



  resources :questions do
    get   :search,    on: :collection
    patch :mark_done, on: :member
    post  :approve

    # get "favourites", on: :collection

    # By defining `resources :answers` nested inside `resources :questions`
    # Rails will defined all the answers routes prepended with
    # `/questions/:question_id`. This enables us to have the question_id handy
    # so we can create the answer associated with a question with `question_id`
    resources :answers, only: [:create, :destroy]

    resources :likes, only: [:create, :destroy]

    resources :favourites, only: [:create, :destroy]

    resources :votes, only: [:create, :update, :destroy]

  end

  resources :likes, only: [:index]
#get  "/questions/new"      => "questions#new",    as: #:new_question
  #post "/questions"          => "questions#create", as: #:questions
#  #get  "/questions/:id"     => "questions#show",   as: #:question
  #get  "/questions"          => "questions#index"
  #get  "/questions/:id/edit" => "questions#edit",   as: #:edit_question
  #patch "/questions/:id"     => "questions#update"
  #delete "/questions/:id"    => "questions#destroy"

  #this defines route that specifies if we get a request that has a GET HTTP verb with '/about' url, use the HhomeController with about action(method)
  get "/about" => "home#about"

  #passing the 'as:' option enables us to have a url/path helper for this route. note that helpers are only for the url portion of the route and has nothing to do
  get "/greet/:name" => "home#greet", as: :greet

  get "/cowsay" => "cowsay#index"
  post "/cowsay" => "cowsay#create"

  # get "/" => "home#index"
  root "home#index"

  get "/temperature" => "temperature#index"

  post "/temperature" => "temperature#convert"




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
