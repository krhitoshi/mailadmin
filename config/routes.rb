Rails.application.routes.draw do

  get 'domains/:id', to: "domains#show", constraints: { id: /[A-Za-z0-9\-.]+/ }
  resources :domains do
  end
end
