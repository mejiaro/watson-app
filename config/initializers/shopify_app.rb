ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "bdab245bc356648291c21656c329cbfa"
  config.secret = "3a5b670fc34f40ae28230850d46bf6ac"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
end
