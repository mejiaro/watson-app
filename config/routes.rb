Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/debug', to: 'home#debug', via: [:get, :post]
  match '/social-sign-in/twitter', to: 'home#twitter', via: [:get, :post]
  match '/suggestions' to: 'home#suggestions', via: [:get, :post]
end
