Rails.application.routes.draw do
  root 'domains#index'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'profile' => 'profile#edit'
  patch 'profile' => 'profile#update'

  resources :admins, only: [:index, :new, :create] do
    member do
      constraints id: ApplicationRecord::RE_EMAIL_LIKE do
        get 'edit'
        patch '', action: 'update', as: ''
        delete '', action: 'destroy'
      end
    end
  end

  resources :domains, only: [:index, :new, :create] do
    member do
      constraints id: ApplicationRecord::RE_DOMAIN_NAME_LIKE do
        get 'edit', action: 'edit'
        get '', action: 'show', as: ''
        patch '', action: 'update'
        delete '', action: 'destroy'
      end
    end

    constraints domain_id: ApplicationRecord::RE_DOMAIN_NAME_LIKE do
      resources :aliases, only: [:index, :new, :create] do
        member do
          constraints id: ApplicationRecord::RE_EMAIL_LIKE do
            get 'edit', action: 'edit'
            patch '', action: 'update', as: ''
            delete '', action: 'destroy'
          end
        end
      end

      resources :mailboxes, only: [:index, :new, :create] do
        member do
          constraints id: ApplicationRecord::RE_EMAIL_LIKE do
            get 'edit', action: 'edit'
            patch '', action: 'update', as: ''
            delete '', action: 'destroy'
          end
        end
      end
    end
  end


end
