Rails.application.routes.draw do
  localized do
    devise_for :users,
               controllers: {
                 sessions: 'sessions'
               },
               path_names: {
                 sign_in:  'login',
                 sign_out: 'logout',
                 recover:  'recover'
               },
               skip: %i[ passwords registrations ],
               path: ''

    get 'users/forgot_password', to: 'users#forgot_password'
    post 'users/send_recover_token', to: 'users#send_recover_token'

    resources :users, param: :scout_name do
      member do
        get 'edit_password'
        match 'update_password', via: %i[ put patch ]

        get 'edit_admin'
        match 'update_admin', via: %i[ put patch ]
      end
    end

    namespace :groups do
      get 'edit_order'
      match 'update_order', via: %i[ put patch ]
    end

    resources :groups, param: :abbreviation do
      member do
        get 'edit_users'
        match 'update_users', via: %i[ put patch ]

        resource :members, only: %i[ new create ]
        resources :members, param: :scout_name, only: %i[ edit update destroy ]

        resources :roles, param: :name
      end
    end


    namespace :events do
      Event.detail_types.each do |detail, _|
        get "#{detail}/new", action: "new_#{detail}"
        post "#{detail}/new", action: "create_#{detail}"
      end
    end

    resources :events

    resources :articles

    resources :albums, param: :name do
      member do
        get 'download'
      end
    end
  end

  root to: redirect('/home')
end
