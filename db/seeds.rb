# frozen_string_literal: true

puts "creating product types"
PT = Comee::Core::ProductType.where(code: "StockItem", name: "Stock Item").first_or_create

puts "creating units"
U = Comee::Core::Unit.where(code: "Each", name: "Each", unit_type: 1).first_or_create

puts "creating users"
Comee::Core::User.where(name: "MAVEKO ADMIN", email: "maveko.admin@test.com", user_type: 1,
  password_digest: BCrypt::Password.create("maveko23#")).first_or_create
hepp_user = Comee::Core::User.where(name: "HEPP", email: "nigussolomon444@gmail.com", user_type: 0,
  password_digest: BCrypt::Password.create("maveko23#")).first_or_create
mafter_user = Comee::Core::User.where(name: "MAFTER", email: "mafter.admin@test.com", user_type: 0,
  password_digest: BCrypt::Password.create("maveko23#")).first_or_create
contacto_user = Comee::Core::User.where(name: "CONTACTO", email: "contacto.admin@test.com", user_type: 0,
  password_digest: BCrypt::Password.create("maveko23#")).first_or_create
client_user = Comee::Core::User.where(name: "AZAMARA", email: "azamara.admin@test.com", user_type: 0,
  password_digest: BCrypt::Password.create("maveko23#")).first_or_create

puts "creating suppliers"
Comee::Core::Supplier.where(code: "SP1231", name: "HEPP", address: "Germany",
  user_id: hepp_user.id).first_or_create
Comee::Core::Supplier.where(code: "SP1232", name: "MAFTER", address: "Germany",
  user_id: mafter_user.id).first_or_create
Comee::Core::Supplier.where(code: "SP1233", name: "CONTACTO", address: "Germany",
  user_id: contacto_user.id).first_or_create

puts "creating clients"
Comee::Core::Client.where(code: "CL1122", user_id: client_user.id, name: "AZAMARA",
  address: "Germany").first_or_create

# puts "creating supplier customer cross reference"
# SupplierCustomerReference.where(supplier_article_number: "SP12310001", customer_item_number: "99PRD30173", supplier_id: supplier_hepp.id, price: 42.30).first_or_create
# SupplierCustomerReference.where(supplier_article_number: "SP12310002", customer_item_number: "99PRD58797", supplier_id: supplier_hepp.id, price: 41.20).first_or_create

# SupplierCustomerReference.where(supplier_article_number: "SP18410001", customer_item_number: "99PRD31040", supplier_id: supplier_mafter.id, price: 120.00).first_or_create
# SupplierCustomerReference.where(supplier_article_number: "SP18410002", customer_item_number: "99PRD31041", supplier_id: supplier_mafter.id, price: 60.00).first_or_create

# SupplierCustomerReference.where(supplier_article_number: "SP13610001", customer_item_number: "99PRD31388", supplier_id: supplier_contacto.id, price: 120.00).first_or_create
# SupplierCustomerReference.where(supplier_article_number: "SP13610002", customer_item_number: "99PRD31399", supplier_id: supplier_contacto.id, price: 60.00).first_or_create
# SupplierCustomerReference.where(supplier_article_number: "SP13610003", customer_item_number: "99PRD31400", supplier_id: supplier_contacto.id, price: 120.00).first_or_create

# SupplierCustomerReference.where(supplier_article_number: "SP18410003", customer_item_number: "99PRD58777", supplier_id: supplier_mafter.id, price: 120.00).first_or_create
# SupplierCustomerReference.where(supplier_article_number: "SP18410004", customer_item_number: "99PRD31405", supplier_id: supplier_mafter.id, price: 60.00).first_or_create

puts "Finished seeding..."
