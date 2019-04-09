Rails.application.routes.draw do
  external_param = /[^\/]+/

  localized do
    devise_for :users,
               controllers: {
                 sessions: 'sessions'
               },
               path_names: {
                 sign_in:  'login',
                 sign_out: 'logout',
               },
               only: %i[ sessions ],
               path: ''

    concern :rankable do |options|
      model = options.fetch(:model)
      collection do
        resource :ranks, only: %i[ edit update ], as: "#{model.name.pluralize.underscore}_ranks", defaults: { model: model }
      end
    end

    resources :users, param: :scout_name do
      member do
        get 'edit_password'
        match 'update_password', via: %i[put patch]

        get 'edit_admin'
        match 'update_admin', via: %i[put patch]
      end
    end

    namespace :groups do
      get 'edit_order'
      match 'update_order', via: %i[put patch]
    end

    resources :groups, param: :abbreviation do
      member do
        get 'edit_users'
        match 'update_users', via: %i[put patch]
      end

      scope module: 'groups' do
        resource :members, only: %i[ new create ]
        resources :members, param: :scout_name, only: %i[ edit update destroy ]
        resources :roles, param: :name
      end
    end

    resources :events, param: :title, constraints: { title: external_param }

    namespace :old_events do
      OldEvent.detail_types.each do |detail, _|
        get "#{detail}/new", action: "new_#{detail}"
        post "#{detail}/new", action: "create_#{detail}"

        scope ':id' do
          get "#{detail}/edit", action: "edit_#{detail}"
          match "#{detail}/edit", action: "update_#{detail}", via: %i[put patch]

          delete detail, action: 'destroy'
        end
      end
    end

    resources :old_events, except: %i[ index show edit ]

    resources :articles, id: external_param

    resources :organizations, param: :abbreviation do
      concerns :rankable, model: Organization
      scope module: :organizations do
        resources :members, {
          only:  %i[ new create edit update destroy ],
          param: :name,
        }
      end
    end

    resources :albums, param: :name, constraints: { name: external_param } do
      member do
        get 'download'
      end
    end

    get '/contact', to: 'contact#index'

    root to: 'home#index'
  end
end
