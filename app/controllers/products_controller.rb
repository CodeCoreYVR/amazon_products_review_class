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

    def edit 
        @product = Product.find params[:id]
    end

    def update 
        product_params = params.require(:product).permit(:title, :description, :price)
        @product = Product.find params[:id]
        if @product.update product_params
            redirect_to product_path(@product)
        else 
            render :edit 
        end
    end

    def show 
        @product = Product.find params[:id]
    end

    def index 
        @products = Product.order(created_at: :DESC)
    end

    def destroy 
        @product = Product.find(params[:id])
        @product.destroy 
        redirect_to products_path
    end
end
