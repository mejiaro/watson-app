ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "5857c42a164d7b0fb38ef5464bd9ec0e"
  config.secret = "c23568d568a5e83d7fbcfc6addba3367"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
end
