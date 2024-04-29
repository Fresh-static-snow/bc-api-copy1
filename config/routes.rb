# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users,
             :skip => [:registrations],
             defaults: { format: :json }, path: '/api/v1',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             },
             controllers: {
               sessions: 'users/sessions',
               invitations: 'users/invitations',
               passwords: 'users/passwords',
             }

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  require 'sidekiq/web'

  mount Sidekiq::Web       => '/sidekiq'
  mount ActionCable.server => '/cable'

  telegram_webhook TelegramWebhookController, :chat

  namespace :api do
    namespace :v1 do
      get :calendar, to: 'calendar#index'
      get 'calendar/filters', to: 'calendar#filters'

      get 'matches/types', to: 'matches#types'

      resources :entity_comments, only: %i[index show create edit update destroy]

      resources :game_disciplines, only: %i[index show create edit update destroy]
      delete 'game_disciplines/:id/soft_destroy', to: 'game_disciplines#soft_destroy'
      put 'game_disciplines/:id/restore', to: 'game_disciplines#restore'

      resources :corporate_companies, only: %i[index show create edit update destroy]
      get 'tournaments/types', to: 'tournaments#types'
      get 'tournaments/:id/media', to: 'tournaments#media'
      get 'tournaments/:id/schedule', to: 'tournaments#schedule'
      get 'tournaments/:id/comments', to: 'tournaments#comments'

      resources :tournaments, only: %i[index show create edit update destroy]
      delete 'tournaments/:id/soft_destroy', to: 'tournaments#soft_destroy'
      put 'tournaments/:id/restore', to: 'tournaments#restore'

      resources :matches, only: %i[index show create edit update destroy] do
        collection do
          delete '/destroy', to: 'matches#bulk_destroy'
          delete '/soft_destroy', to: 'matches#bulk_soft_destroy'
          put '/restore', to: 'matches#bulk_restore'
        end

        member do
          delete '/soft_destroy', to: 'matches#soft_destroy'
          put '/restore', to: 'matches#restore'
        end
      end

      get 'corporates/:id/comments', to: 'corporates#comments'
      resources :corporates, only: %i[show create edit update destroy]

      get 'roles/permissions', to: 'roles#permissions'
      resources :roles, only: %i[index show create edit update destroy]

      resources :regions, only: %i[index show create edit update destroy]

      resources :sponsors, only: %i[index show create edit update destroy]
      delete 'sponsors/:id/soft_destroy', to: 'sponsors#soft_destroy'
      put 'sponsors/:id/restore', to: 'sponsors#restore'

      resources :teams, only: %i[index show create edit update destroy]
      delete 'teams/:id/soft_destroy', to: 'teams#soft_destroy'
      put 'teams/:id/restore', to: 'teams#restore'

      get 'branding/main', to: 'branding#main'
      put 'branding/change', to: 'branding#change'
      resources :branding, only: %i[index show create edit update destroy]
      delete 'branding/:id/soft_destroy', to: 'branding#soft_destroy'
      put 'branding/:id/restore', to: 'branding#restore'

      resources :user_disciplines, only: %i[index show create edit update destroy]
      resources :user_companies, only: %i[index show create edit update destroy]

      put 'users/change_password', to: 'users#change_password'
      get 'users/authenticated', to: 'authenticated_users#authenticated'
      get 'users/permissions', to: 'user_permissions#permissions'
      post 'users/add_calendar_access', to: 'google_calendar#add_calendar_access'
      get 'users/authenticated/notifications', to: 'authenticated_users#authenticated_notifications'
      get 'users/authenticated/notifications/count', to: 'authenticated_users#notifications_count'
      resources :users, only: %i[index show create edit update destroy]
      post 'users/:id/update_avatar', to: 'users#update_avatar'
      get 'users/:id/notifications', to: 'user_notifications#notifications'
      delete 'users/:id/soft_destroy', to: 'users#soft_destroy'
      put 'users/:id/restore', to: 'users#restore'
      get 'users/:id/resent_invite', to: 'users#resent_invite'

      resource :settings, only: %i[show update]

      post 'user_notifications/read', to: 'user_notifications#mark_as_read'

      get 'google_calendar/oauth', to: 'google_calendar#oauth'
      get 'google_calendar/oauth_callback', to: 'google_calendar#callback'

      namespace :casts do
        resources :languages, only: %i[index show create edit update destroy]
        delete 'languages/:id/soft_destroy', to: 'languages#soft_destroy'
        put 'languages/:id/restore', to: 'languages#restore'

        resources :analytic_studios, only: %i[index show create edit update destroy]
        delete 'analytic_studios/:id/soft_destroy', to: 'analytic_studios#soft_destroy'
        put 'analytic_studios/:id/restore', to: 'analytic_studios#restore'

        resources :studios, only: %i[index show create edit update destroy]
        delete 'studios/:id/soft_destroy', to: 'studios#soft_destroy'
        put 'studios/:id/restore', to: 'studios#restore'

        resources :channels, only: %i[index show create edit update destroy]
        delete 'channels/:id/soft_destroy', to: 'channels#soft_destroy'
        put 'channels/:id/restore', to: 'channels#restore'
      end

      get 'dashboard/counts', to: 'dashboard#counts'
      get 'dashboard/users', to: 'dashboard#users'
      get 'dashboard/companies', to: 'dashboard#companies'
      get 'dashboard/notifications', to: 'dashboard#notifications'

      get 'items', to: 'management_items#items'
    end
  end

  mount ActionCable.server => '/cable'

end
