class ProductsController < ApplicationController
    def new 
        @product = Product.new
    end

    def create 
        product_params = params.require(:product).permit(:title, :description, :price)
        @product = Product.new product_params
        if @product.save
            redirect_to @product
        else
            render :new 
        end
    end

    def show 
        @product = Product.find params[:id]
    end

    def index 
        @products = Product.order(created_at: :DESC)
    end
end
