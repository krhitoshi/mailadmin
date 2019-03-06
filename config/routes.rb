Rails.application.routes.draw do

  get 'domains/:id', to: "domains#show", constraints: { id: /[A-Za-z0-9\-.]+/ }
  resources :domains do
  end

  get 'aliases/:id/edit', to: "aliases#edit", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  patch 'aliases/:id', to: "aliases#update", constraints: { id: /[A-Za-z0-9\-.@]+/ }
  resources :aliases
end
