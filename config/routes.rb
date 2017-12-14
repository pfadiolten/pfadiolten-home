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
  end
end
