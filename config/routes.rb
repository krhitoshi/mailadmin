Rails.application.routes.draw do

  get 'admins/:id/edit', to: "admins#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'admins/:id', to: "admins#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :admins

  get 'domains/:id', to: "domains#show", constraints: { id: /[A-Za-z0-9\-.]+/ }
  resources :domains do
  end

  get 'mailboxes/:id/edit', to: "mailboxes#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'mailboxes/:id', to: "mailboxes#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :mailboxes

  get 'aliases/:id/edit', to: "aliases#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'aliases/:id', to: "aliases#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :aliases
end
