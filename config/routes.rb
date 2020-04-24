Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/products/new" => "products#new", as: :new_product
  post "/products" => "products#create", as: :products
end
