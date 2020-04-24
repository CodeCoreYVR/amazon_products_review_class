Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  # get "/products/new" => "products#new", as: :new_product
  # post "/products" => "products#create", as: :products
  # get "/products/:id" => "products#show", as: :product 
  # get "/products" => "products#index"
  # delete "/products/:id" => "products#destroy"
  # get "/products/:id/edit" => "products#edit", as: :edit_product
  # patch "/products/:id" => "products#update"
  
  resources :products
end
