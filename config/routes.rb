Passeme::Application.routes.draw do

  #scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' },
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  constraints subdomain: "demo" do
    get "/" => 'demo#login'
  end


  match '/demo', to: 'demo#login', via: 'get', as: 'demo'

  resources :users
  resources :tasks do
    member do
      put 'toggle_done'
    end
    collection do
      get 'list_all'
      get 'list_pending'
      get 'list_done'
      get 'list_overdue'
    end
  end

  resources :notifications
  resources :groups
  resources :settings
  resources :subjects do
    get 'study_sources'
    patch 'study_sources', to: 'subjects#update_study_sources'
    patch 'update_subject_group'
  end

  resources :study_sources
  resources :timetables do
    put 'make_active'
    get 'follow_up', to: 'follow_up#index'
    get 'reports', to: 'reports#index'
  end
  #Get the active timetable
  get 'follow_up', to: 'follow_up#index_active_timetable'
  get 'reports', to: 'reports#index_active_timetable'
  get 'change_timetable_report', to: 'reports#change_timetable'
  resources :calendars do
    resources :calendar_events do
      get 'edit_complete'
      put 'complete'
      put 'info_net_hours'
    end
    resources :calendar_event_sources, as: 'event_sources'
    get 'get_study_sources_for_event_source', to: 'calendar_event_sources#get_study_sources'

    get 'event_instances', to: "event_instances#index"
    post 'day_click'
    post 'event_click'
    post 'select'
  end

  resources :subject_groups


  devise_scope :user do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  match '/about', to: 'static_pages#about', via: 'get', as: 'about'

  #end

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
