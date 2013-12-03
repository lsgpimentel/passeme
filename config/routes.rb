Passeme::Application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' },
      controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

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
    resources :syllabuses do
      resources :timetables
    end
    resources :calendars do
      resources :calendar_events

      post 'event_sources'
      post 'event_resize'
      post 'select'
      post 'event_drop'
      post 'day_click'
      post 'event_click'
    end
    post '/syllabuses/:syllabus_id/event_sources_from_study_times', controller: :timetables, action: :event_sources_from_study_times, as: :event_sources_from_study_times
    resources :subject_groups


    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'static_pages#home'
    end

    match '/about', to: 'static_pages#about', via: 'get', as: 'about'

  end

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
