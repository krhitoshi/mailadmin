Rails.application.routes.draw do
  RE_DOMAIN_NAME_LIKE = /([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/
  RE_ADDRESS_LIKE = /[A-Za-z0-9\-.]+@([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/

  root 'domains#index'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :admins, only: [:index, :new, :create] do
    member do
      get 'edit', constraints: { id: RE_ADDRESS_LIKE }
      patch '', action: 'update', constraints: { id: RE_ADDRESS_LIKE }, as: ''
      delete '', action: 'destroy', constraints: { id: RE_ADDRESS_LIKE }
    end
  end

  resources :domains, only: [:index, :new, :create] do
    member do
      get 'edit', action: 'edit', constraints: { id: RE_DOMAIN_NAME_LIKE }
      get '', action: 'show', constraints: { id: RE_DOMAIN_NAME_LIKE }, as: ''
      patch '', action: 'update', constraints: { id: RE_DOMAIN_NAME_LIKE }
      delete '', action: 'destroy', constraints: { id: RE_DOMAIN_NAME_LIKE }
    end
  end

  resources :mailboxes, only: [:index, :new, :create] do
    member do
      get 'edit', action: 'edit', constraints: { id: RE_ADDRESS_LIKE }
      patch '', action: 'update', constraints: { id: RE_ADDRESS_LIKE }, as: ''
      delete '', action: 'destroy', constraints: { id: RE_ADDRESS_LIKE }
    end
  end

  resources :aliases, only: [:index, :new, :create] do
    member do
      get 'edit', action: 'edit', constraints: { id: RE_ADDRESS_LIKE }
      patch '', action: 'update', constraints: { id: RE_ADDRESS_LIKE }, as: ''
      delete '', action: 'destroy', constraints: { id: RE_ADDRESS_LIKE }
    end
  end
end
