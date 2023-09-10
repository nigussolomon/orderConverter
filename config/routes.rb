Rails.application.routes.draw do
  mount Comee::Core::Engine => "/comee_core", as: "comee_core"

  get "/setups/items", to: "setups#get_items"
  get "/setups/customers", to: "setups#get_customers"
  get "/setups/suppliers", to: "setups#get_suppliers"
  get "/setups/so", to: "setups#get_so"
  get "/setups/sos/:poNumber/:", to: "setups#create_so"
  get "/setups/pos/:poNumber", to: "setups#create_po"
end
