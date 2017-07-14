class HomeController < ShopifyApp::AuthenticatedController
  #include ShopifyApp::AppProxyVerification
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    #173202373
  end

end
