Rails.application.routes.draw do
  RE_DOMAIN_NAME_LIKE = /([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/
  RE_ADDRESS_LIKE = /[A-Za-z0-9\-.]+@([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/

  root 'domains#index'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :admins, only: [:index, :new, :create] do
    member do
      constraints id: RE_ADDRESS_LIKE do
        get 'edit'
        patch '', action: 'update', as: ''
        delete '', action: 'destroy'
      end
    end
  end

  resources :domains, only: [:index, :new, :create] do
    member do
      constraints id: RE_DOMAIN_NAME_LIKE do
        get 'edit', action: 'edit'
        get '', action: 'show', as: ''
        patch '', action: 'update'
        delete '', action: 'destroy'
      end
    end
  end

  resources :mailboxes, only: [:index, :new, :create] do
    member do
      constraints id: RE_ADDRESS_LIKE do
        get 'edit', action: 'edit'
        patch '', action: 'update', as: ''
        delete '', action: 'destroy'
      end
    end
  end

  resources :aliases, only: [:index, :new, :create] do
    member do
      constraints id: RE_ADDRESS_LIKE do
        get 'edit', action: 'edit'
        patch '', action: 'update', as: ''
        delete '', action: 'destroy'
      end
    end
  end
end
