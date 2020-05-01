class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_product, only: [:show, :edit, :update, :destroy]

    def new 
        @product = Product.new
    end

    def create 
        @product = Product.new product_params
        @product.user = @current_user
        if @product.save
            redirect_to @product
        else
            render :new 
        end
    end

    def edit 
    end

    def update 
        if @product.update product_params
            redirect_to product_path(@product)
        else 
            render :edit 
        end
    end

    def show 
        @review = Review.new 
        # In this case only the product owner will have all reviews available in the 
        # through @reviews (including hidden reviews).
        # You ccould also remove this logic here and do some logic in the view. Your
        # use case (and for now, the size of  your Rails toolset) will determine the best way
        # to things. We've done it this way because with the tools available to us 
        # it minimizes the amount of repeated code an d if else statements in our view. 
        if can? :manage, @product 
            @reviews = @product.reviews.order(created_at: :desc)
        else
            @reviews = @product.reviews.where(hidden: false).order(created_at: :desc)
        end 
    end

    def index 
        @products = Product.order(created_at: :DESC)
    end

    def destroy 
        @product.destroy 
        redirect_to products_path
    end

    private 

    def product_params
        params.require(:product).permit(:title, :description, :price)
    end

    def find_product 
        @product = Product.find params[:id]
    end
end
