class ProductsController < ApplicationController
    def new 
        @product = Product.new
    end

    def create 
        product_params = params.require(:product).permit(:title, :description, :price)
        @product = Product.new product_params
        if @product.save
            render plain: 'Product Created'
        else
            render :new 
        end
    end
end
