Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/debug', to: 'kiwi#debug', via: [:get, :post]
  match '/authorize', to: 'kiwi#authorize', via: [:get, :post]
  match '/analyse', to: 'kiwi#twitter', via: [:get, :post]
  match '/suggestions', to: 'kiwi#suggestions', via: [:get, :post]
  match '/test', to: 'kiwi#debug', via: [:get]
end
