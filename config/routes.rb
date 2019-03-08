Rails.application.routes.draw do

  get 'admins/:id/edit', to: "admins#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'admins/:id', to: "admins#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  delete 'admins/:id', to: "admins#destroy", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :admins

  get 'domains/new', to: "domains#new"
  get 'domains/:id', to: "domains#show", constraints: { id: /[A-Za-z0-9\-.]+/ }
  get 'domains/:id/edit', to: "domains#edit", constraints: { id: /[A-Za-z0-9\-.]+/ }
  patch 'domains/:id', to: "domains#update", constraints: { id: /[A-Za-z0-9\-.]+/ }
  delete 'domains/:id', to: "domains#destroy", constraints: { id: /[A-Za-z0-9\-.]+/ }
  resources :domains

  get 'mailboxes/:id/edit', to: "mailboxes#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'mailboxes/:id', to: "mailboxes#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  delete 'mailboxes/:id', to: "mailboxes#destroy", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :mailboxes

  get 'aliases/:id/edit', to: "aliases#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'aliases/:id', to: "aliases#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  delete 'aliases/:id', to: "aliases#destroy", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :aliases
end
