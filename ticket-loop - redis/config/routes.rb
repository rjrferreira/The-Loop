Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'tickets/show'
  root to: "tickets#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
