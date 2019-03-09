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

  get 'domains/new', to: "domains#new"
  get 'domains/:id', to: "domains#show", constraints: { id: RE_DOMAIN_NAME_LIKE }
  get 'domains/:id/edit', to: "domains#edit", constraints: { id: RE_DOMAIN_NAME_LIKE }
  patch 'domains/:id', to: "domains#update", constraints: { id: RE_DOMAIN_NAME_LIKE }
  delete 'domains/:id', to: "domains#destroy", constraints: { id: RE_DOMAIN_NAME_LIKE }
  resources :domains

  get 'mailboxes/:id/edit', to: "mailboxes#edit", constraints: { id: RE_ADDRESS_LIKE }
  patch 'mailboxes/:id', to: "mailboxes#update", constraints: { id: RE_ADDRESS_LIKE }
  delete 'mailboxes/:id', to: "mailboxes#destroy", constraints: { id: RE_ADDRESS_LIKE }
  resources :mailboxes

  get 'aliases/:id/edit', to: "aliases#edit", constraints: { id: RE_ADDRESS_LIKE }
  patch 'aliases/:id', to: "aliases#update", constraints: { id: RE_ADDRESS_LIKE }
  delete 'aliases/:id', to: "aliases#destroy", constraints: { id: RE_ADDRESS_LIKE }
  resources :aliases
end
